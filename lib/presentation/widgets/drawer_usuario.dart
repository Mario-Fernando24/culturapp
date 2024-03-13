import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/cubits/directoryArtistaCubit/directory_artista_usuario_cubit.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/widgets/icons_drawer.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerUsuario extends StatefulWidget {
  const DrawerUsuario({super.key});

  @override
  State<DrawerUsuario> createState() => _DrawerUsuarioState();
}

class _DrawerUsuarioState extends State<DrawerUsuario> {
  bool auxiliar = false;

  @override
  void initState() {
    // TODO: implement initState
    _validateLogin();
    super.initState();
  }

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
            
                    iconDrawer('assets/icons/agenda_cultural_icon.png', context),
          
                    Text(
                      'Agenda cultural',
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
                    iconDrawer('assets/icons/ofertaaaaa.png', context),
                    Text('Oferta cultural ',
                          style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 13,

                        )),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, usersOfertaCulturalHomeRoute);
                },
              ),
            ),
            

            
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorDirectorioArtista,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconDrawer('assets/icons/directori_artista_icon.png', context),
                    Text('Directorio de artista',
                    textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 13,

                        )),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, usersDirectorioArtistaHomeRoute);
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorDirectorioArtista_agentes_cultural,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconDrawer('assets/icons/AMMgentres_culturales.png', context),
                    Text('Agentes cultural',
                    textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 13,
                        )),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, usersAgenteCulturalHomeRoute);
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.166,
              child: ListTile(
                tileColor: colorDirectorioArtista_gestor_cultural,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconDrawer('assets/icons/Gestores____culturales.png', context),
                    Text('Gestores cultural',
                    textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 13,
                        )),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, usersGestorCulturalHomeRoute);
                },
              ),
            ),
          //  auxiliar==false? Container(
          //     height: MediaQuery.of(context).size.height * 0.166,
          //     child: ListTile(
          //       tileColor: Colors.redAccent,
          //       title: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Icon(Icons.exit_to_app, color: colorWhite, size: 40),
          //           Text('Salir',
          //               style: TextStyle(
          //                 color: colorWhite,
          //                 fontWeight: FontWeight.bold,
          //                 fontFamily: 'Roboto',
          //                 fontSize: 13,
          //               )),
          //         ],
          //       ),
          //       onTap: () {
          //         context.read<AuthenticationCubit>().logOut();
          //         _validateLogin();
          //         Navigator.pushNamedAndRemoveUntil(
          //             context, homeUserviewRoutes, (route) => false);
          //       },
          //     ),
          //   ):Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _validateLogin() async {
    final resp = await context.read<DirectoryArtistaCubit>().getCurrent();
    if (resp == 'null') {
      
      await UserPreferences.setBoolPreference('logout', false);
    } else {
      await UserPreferences.setBoolPreference('logout', true);
    }
  }
}
