import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget drawer_menu(BuildContext context, Color color) {
  return Drawer(
        child: ListView(
          padding: EdgeInsets.only(left: 10),
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: 130.0,
                      height: 130.0,
                      child: Image.asset(
                        'assets/images/logoapp.png',
                      )),
                  Text(
                    'Mario Muñoz',
                    style: TextStyle(color: PrimaryBlackColors, fontSize: 18),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.01,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 50,
              ),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, size: 35, color: Colors.black),
              title: Text('Home',
                  style: TextStyle(fontSize: 20, color: PrimaryBlackColors)),
              onTap: () => Navigator.pushNamed(context, homeAdminviewRoutes),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined,
                  size: 35, color: Colors.black),
              title: Text('Mi perfil',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () => Navigator.pushNamed(context, profileUsviewRoutes),
            ),
            ListTile(
              leading: Icon(Icons.event, size: 35, color: Colors.black),
              title: Text('Agenda cultural',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () =>
                  Navigator.pushNamed(context, agendaCulturalListviewRoutes),
            ),
            ListTile(
              leading: FaIcon(
                      FontAwesomeIcons.addressBook,
                      size: 35,
                      color: Colors.black,
                    ),
              title: Text('Directorio de artista',
                  style: TextStyle(fontSize: 20, color: PrimaryBlackColors)),
              onTap: () => Navigator.pushNamed(
                  context, homeArtistaDirectorio),
            ),
            ListTile(
              leading: Icon(Icons.campaign_sharp,
                  size: 40, color: Colors.black),
              title: Text('Oferta cultural',
                  style: TextStyle(fontSize: 20, color: PrimaryBlackColors)),
              onTap: () =>
                  Navigator.pushNamed(context, ofertaCulturalHomeviewRoutes),
            ),
            ListTile(
                leading:
                    Icon(Icons.exit_to_app, size: 35, color: Colors.black),
                title: Text('Salir',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                onTap: () => {
                      context.read<AuthenticationCubit>().logOut(),
                      Navigator.pushNamedAndRemoveUntil(context, homeUserviewRoutes, (route) => false)
                    }),
            SizedBox(height: SizeConfig.screenHeight! * 0.22),
            Padding(
              padding: EdgeInsets.only(right: 20, bottom: 40, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => context.read<HomeCubit>().urlGlobal(url_facebook),
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () =>context.read<HomeCubit>().urlGlobal(url_instagram),
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () =>context.read<HomeCubit>().urlGlobal(url_tiktok),
                      child: FaIcon(FontAwesomeIcons.tiktok, size: 40)
                      ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () =>context.read<HomeCubit>().urlGlobal(url_youtube),
                    child: FaIcon(
                      FontAwesomeIcons.youtube,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () =>context.read<HomeCubit>().urlGlobal(url_whatsapp),
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 40,
                      color: Color.fromRGBO(76, 175, 80, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
