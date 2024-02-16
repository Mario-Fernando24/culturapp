import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                height: SizeConfig.screenHeight! * 0.35,
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.evento!.descriptionEvento,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendarCheck,
                        size: 40,
                        color: Colors.red,
                      ),
                      Text(
                        "Fecha del evento \n" +
                            parsearDateTime(widget.evento!.fechaEvento),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.locationArrow,
                        size: 40,
                        color: Colors.red,
                      ),
                      Text(
                        "Dirección\n" + widget.evento!.direccionEvento,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().openGoogleMaps(
                              widget.evento!.latitud, widget.evento!.longitud);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.mapLocation,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().openGoogleMaps(
                              widget.evento!.latitud, widget.evento!.longitud);
                        },
                        child: widget.evento!.estado == true
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                size: 50,
                                color: Colors.green[900],
                              )
                            : FaIcon(
                                FontAwesomeIcons.circleInfo,
                                size: 50,
                                color: Colors.red[900],
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
