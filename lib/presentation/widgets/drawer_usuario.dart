import 'package:culturappco/config/themes/app_style.dart';
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
                    color: Color(0xffEB5C60),
                    child: Icon(
                      Icons.close,
                      size: 45,
                      color: Colors.white,
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.166,
                child: ListTile(
                  tileColor: Color(0xffED6567),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.calendar_today, color: colorWhite, size: 40,),
                      Text('Minha agenda',style: TextStyle(color: colorWhite),),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.166,
                child: ListTile(
                  tileColor: Color(0xffD31D2A),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.image, color: colorWhite,size: 40),
                      Text('Artes Visuais',style: TextStyle(color: colorWhite)),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.166,
                child: ListTile(
                  tileColor: Color(0xffEC6521),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.movie , color: colorWhite,size: 40),
                      Text('Cine & Video',style: TextStyle(color: colorWhite)),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.166,
                child: ListTile(
                  tileColor: Color(0xffF8AD20),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.music_note, color: colorWhite, size: 40),
                      Text('Música',style: TextStyle(color: colorWhite)),
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
                      Icon(Icons.theater_comedy , color: colorWhite, size: 40),
                      Text('Teatro',style: TextStyle(color: colorWhite)),
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