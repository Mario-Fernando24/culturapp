import 'dart:io';

import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfertaCulturalDetails extends StatefulWidget {
  final OfertaCultural? ofertaCultural;

  OfertaCulturalDetails({required this.ofertaCultural});

  @override
  State<OfertaCulturalDetails> createState() => _OfertaCulturalDetailsState();
}

class _OfertaCulturalDetailsState extends State<OfertaCulturalDetails> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> miMapa = {
      'clave1': widget.ofertaCultural!.image1 ?? "",
      'clave2': widget.ofertaCultural!.image2 ?? "",
      'clave3': widget.ofertaCultural!.image3 ?? "",
    };

    return Scaffold(
      appBar: AppBar(
          title: Text('Detalles Oferta cultural'),
          backgroundColor: colorOfertaCultural,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )),
      body: _container(context, miMapa),
      bottomNavigationBar: contactosIconos(),
    );
  }

  Widget _container(BuildContext context, Map<String, String> mapa) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _bannerOfertaCultura(context, mapa),
          titleOfertaCulturalForm(),
          descripctionOfertaCulturalForm(),
          _fechaOfertaCultural(context),
        ],
      ),
    );
  }

  Widget _bannerOfertaCultura(BuildContext context, Map<String, String> mapa) {
    return Container(
      height: SizeConfig.screenHeight! * 0.3,
      child: PageView.builder(
        itemCount: mapa.length,
        itemBuilder: (context, index) {
          return Container(
            width: SizeConfig.screenHeight! * 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: mapa[index].toString() != null
                        ? NetworkImage(mapa['clave${index + 1}'].toString())
                        : AssetImage('assets/images/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleOfertaCulturalForm() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15, left: 15),
      child: Text(widget.ofertaCultural!.titleOfertaCultural ?? "",
          style: kTitleBlackcolor),
    );
  }

  Widget descripctionOfertaCulturalForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
      child: Text(widget.ofertaCultural!.description ?? "",
          style: TextStyle(
            fontSize: 18,
          )),
    );
  }

  Widget _fechaOfertaCultural(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10, bottom: 15),
      child: Column(
        children: [
          redesSocialesDrawer("assets/images/bless_ring.svg", 44, 44),
          SizedBox(height: 6.0),
          Text(parsearDateTime(widget.ofertaCultural!.fecha.toString()) ?? "", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
          
          ],
      ),
    );
  }

  Widget contactosIconos() {
    return const Padding(
      padding: EdgeInsets.only(right: 20, bottom: 40, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(
            FontAwesomeIcons.facebook,
            size: 40,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.instagram,
            size: 40,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          FaIcon(FontAwesomeIcons.tiktok, size: 40),
          SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.youtube,
            size: 40,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.whatsapp,
            size: 40,
            color: Color.fromRGBO(76, 175, 80, 1),
          ),
        ],
      ),
    );
  }
}
