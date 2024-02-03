import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

class OfertaCulturalHome extends StatefulWidget {
  const OfertaCulturalHome({super.key});

  @override
  State<OfertaCulturalHome> createState() => _OfertaCulturalHomeState();
}

class _OfertaCulturalHomeState extends State<OfertaCulturalHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Oferta cultural'),
      ),
      drawer: drawer_menu(context, Colors.black),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ofertaCulturalAddviewRoutes);
        },
        // ignore: sort_child_properties_last
        child: Icon(
          Icons.add,
          size: 40,
          weight: 20,
          color: kPrimaryColor,
        ),
        backgroundColor: kSecondaryColor,
      ),
    );
  }
}