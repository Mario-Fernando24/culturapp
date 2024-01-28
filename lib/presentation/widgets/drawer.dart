import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

Widget drawer_menu(BuildContext context, Color color) {
  return BlocConsumer<AuthenticationCubit, AuthenticationState>(
    listener: (context, state) {
      if (state is Unauthenticated) {
        Navigator.pushNamedAndRemoveUntil(context, loginViewRoutes, (route) => false);
      }
    },
    builder: (context, state) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.only(left: 20),
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: 90.0,
                      height: 90.0,
                      child: Image.asset(
                        'assets/images/logoapp.png',
                      )),
                  Text(
                    'Admin',
                    style: TextStyle(color: kSecondaryColor, fontSize: 18),
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
              leading: Icon(Icons.home, size: 35, color: kPrimaryColor),
              title: Text('Home',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor)),
              onTap: () => Navigator.pushNamed(context, homeAdminviewRoutes),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined,
                  size: 35, color: kPrimaryColor),
              title: Text('Mi perfil',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor)),
              onTap: () => Navigator.pushNamed(context, profileUsviewRoutes),
            ),
            ListTile(
              leading: Icon(Icons.event, size: 35, color: kPrimaryColor),
              title: Text('Agenda cultural',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor)),
              onTap: () => Navigator.pushNamed(context, agendaCulturalListviewRoutes),
            ),
            ListTile(
              leading: Icon(Icons.library_music_sharp,
                  size: 35, color: kPrimaryColor),
              title: Text('Directorio de artista',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor)),
              onTap: () => Navigator.pushNamed(context, homeDirectorioArtistaCulturalviewRoutes),
            ),
            ListTile(
                leading:
                    Icon(Icons.exit_to_app, size: 35, color: kPrimaryColor),
                title: Text('Salir',
                    style: TextStyle(fontSize: 20, color: kSecondaryColor)),
                onTap: () => {
                      context.read<AuthenticationCubit>().logOut(),
                    }),
            SizedBox(height: SizeConfig.screenHeight! * 0.31),
            Padding(
              padding: const EdgeInsets.only(right: 80, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  redesSocialesDrawer('assets/images/facebook.svg'),
                  redesSocialesDrawer('assets/images/twiter.svg'),
                  redesSocialesDrawer('assets/images/instagram.svg')
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
