import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Cultura app'),
        ),
        drawer: drawer_menu(context,Colors.black),
        body: Center(
          child: Text('Contenido principal de la aplicación'),
        ),
      );
    
  }
}
