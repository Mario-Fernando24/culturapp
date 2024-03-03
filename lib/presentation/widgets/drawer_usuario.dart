import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

class DrawerUsuario extends StatefulWidget {
  const DrawerUsuario({super.key});

  @override
  State<DrawerUsuario> createState() => _DrawerUsuarioState();
}

class _DrawerUsuarioState extends State<DrawerUsuario> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.33,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.166,
                  padding: EdgeInsets.all(16.0),
                  color: colorAgendaCulturalOscuro,
                  child: Icon(
                    Icons.close,
                    size: 45,
                    color: Colors.white,
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorAgendaCultural,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.event,
                        color: colorWhite,
                        size: 40,
                      ),
                    ),
                    Text(
                      'Agenda cultural',
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, homeUserviewRoutes);
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorOfertaCultural,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.campaign_sharp, color: colorWhite, size: 40),
                    Text('Oferta cultural ',
                        style: TextStyle(
                          color: colorWhite,
                          fontFamily: 'Roboto',
                        )),
                  ],
                ),
                onTap: () {},
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorDirectorioArtista,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.music_note, color: colorWhite, size: 40),
                    Text('Artista',
                        style: TextStyle(
                          color: colorWhite,
                          fontFamily: 'Roboto',
                        )),
                  ],
                ),
                onTap: () {},
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorAgendaCultural,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.theater_comedy, color: colorWhite, size: 40),
                    Text('Agente cultural',
                        style: TextStyle(
                          color: colorWhite,
                          fontFamily: 'Roboto',
                        )),
                  ],
                ),
                onTap: () {},
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: Color(0xffA6C83E),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.movie, color: colorWhite, size: 40),
                    Text('Gestor cultural',
                        style: TextStyle(
                          color: colorWhite,
                          fontFamily: 'Roboto',
                        )),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
