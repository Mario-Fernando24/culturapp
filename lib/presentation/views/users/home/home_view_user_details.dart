import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeViewUserDetails extends StatefulWidget {
  final Evento? evento;

  HomeViewUserDetails({required this.evento});

  @override
  State<HomeViewUserDetails> createState() => _HomeViewUserDetailsState();
}

class _HomeViewUserDetailsState extends State<HomeViewUserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xffED6567),
          size: 30,
        ),
      ),
      toolbarHeight: 70.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Alinea el contenido al final (derecha)
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logovert.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
     ),
      body: _container(),
    );
  }

  Widget _container() {
    return SingleChildScrollView(
      child: Column(
        children: [_imageHome(), titleHome(), descriptionHome(), _showMap()],
      ),
    );
  }

  Widget _imageHome() {
    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      FadeInImage(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        fit: BoxFit.cover,
        image: NetworkImage(widget.evento!.imagen),
        placeholder: AssetImage('assets/images/loading.gif'),
        fadeInDuration: Duration(milliseconds: 200),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: Colors.transparent,
          child: Text(
            '${parsearDateTime(widget.evento!.fechaEvento)}',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    ]);
  }

  Widget titleHome() {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Text(
          widget.evento!.tituloEvento,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ));
  }

  Widget descriptionHome() {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Text(
          widget.evento!.descriptionEvento,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: const Color.fromARGB(255, 65, 63, 63),
            fontFamily: 'Roboto',
          ),
        ));
  }

  Widget _showMap() {
    return Center(
      child: Card(
        elevation: 9.0,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(widget.evento!.latitud, widget.evento!.longitud),
                  zoom: 13.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('1'),
                    position:
                        LatLng(widget.evento!.latitud, widget.evento!.longitud),
                  ),
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.evento!.direccionEvento,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                    color: const Color.fromARGB(255, 65, 63, 63),
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
