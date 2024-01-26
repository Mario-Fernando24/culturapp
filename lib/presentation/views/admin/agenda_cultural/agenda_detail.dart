import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgendaDetails extends StatefulWidget {
  final Evento? evento;

  AgendaDetails({required this.evento});

  @override
  State<AgendaDetails> createState() => _AgendaDetailsState();
}

class _AgendaDetailsState extends State<AgendaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo claro
      appBar: AppBar(
          title: Text('Detalles del Evento'),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              child: FadeInImage(
                height: SizeConfig.screenHeight!*0.35,
                fit: BoxFit.cover,
                image: NetworkImage(widget.evento!.imagen),
                placeholder: AssetImage('assets/images/loading.gif'),
                fadeInDuration: Duration(milliseconds: 200),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.evento!.tituloEvento,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.evento!.descriptionEvento,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Fecha del evento \n" +
                        parsearDateTime(widget.evento!.fechaEvento),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Dirección\n" + widget.evento!.direccionEvento,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor, // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      context.read<HomeCubit>().openGoogleMaps(
                          widget.evento!.latitud, widget.evento!.longitud);
                    },
                    icon: Icon(Icons.map, color: Colors.white),
                    label: Text('Ver Ubicación en Mapa',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      primary: kPrimaryColor, // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(
                      widget.evento!.estado == true
                          ? Icons.check_circle_sharp
                          : Icons.cancel_rounded,
                      color: widget.evento!.estado == true
                          ? Color.fromARGB(255, 4, 88, 8)
                          : Colors.red,
                      size: 30,
                    ),
                    label: Text(
                        widget.evento!.estado == true
                            ? 'HABILITADO'
                            : 'INHABILITADO',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
