import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class AgendaCulturalList extends StatefulWidget {
  const AgendaCulturalList({super.key});

  @override
  State<AgendaCulturalList> createState() => _AgendaCulturalListState();
}

class _AgendaCulturalListState extends State<AgendaCulturalList> {
  List<Evento> listEventos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Agenda cultural'),
      ),
      drawer: drawer_menu(context, Colors.black),
      body: _listAgendaCultural(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, addAgendaCulturalviewRoutes);
        },
        child: Icon(
          Icons.add,
          color: kPrimaryColor,
        ),
        backgroundColor: kSecondaryColor,
      ),
    );
  }

  Widget _listAgendaCultural() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetEvents) {
          listEventos.addAll(state.listEvents);
        }
        return _listEvento();
            
         
      },
    );
  }

  Widget _listEvento() {
    return SizedBox(
      height: SizeConfig.screenHeight! * 200,
      child: ListView.builder(
          itemCount: listEventos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            return _tarjetaCollections(context, listEventos[index]);
          }),
    );
  }

  Widget _tarjetaCollections(BuildContext context, Evento evento) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            evento.imagen, // URL de la imagen
            width: 80,
            height: 90,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(evento.tituloEvento,textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(evento.descriptionEvento, textAlign: TextAlign.justify,)
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  evento.estado == true
                      ? Icons.check_circle_sharp
                      : Icons.cancel_rounded,
                  color: evento.estado == true
                      ? Color.fromARGB(255, 4, 88, 8)
                      : Colors.red,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.location_on_sharp,
                  color: kPrimaryColor,
                  size: 30.0,
                ),
                onPressed: () {
                      context.read<HomeCubit>().openGoogleMaps(evento.latitud, evento.longitud);

                },
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
  // Widget _tarjetaCollections(BuildContext context, Evento evento) {
  //   return Center(
  //         child: Card(
  //           elevation: 8,
  //           child: ListTile(
  //             contentPadding: EdgeInsets.all(16),
  //             leading: Image.network(
  //               evento.imagen, // URL de la imagen
  //               width: 80,
  //               height: 80,
  //               fit: BoxFit.cover,
  //             ),
  //             title: Text('Título'),
  //             subtitle: Text(evento.de),
  //             trailing: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     // Acciones al hacer clic en el botón
  //                   },
  //                   child: Text('Botón'),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Icon(Icons.star, color: Colors.yellow),
  //               ],
  //             ),
  //           ),
  //         ));
  // }
}
