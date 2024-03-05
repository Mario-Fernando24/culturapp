import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsersOfertaCulturaDetails extends StatefulWidget {
  final OfertaCultural? ofertaCultural;

  UsersOfertaCulturaDetails({required this.ofertaCultural});

  @override
  State<UsersOfertaCulturaDetails> createState() =>
      _UsersOfertaCulturaDetailsState();
}

class _UsersOfertaCulturaDetailsState extends State<UsersOfertaCulturaDetails> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> miMapa = {
      'clave1': widget.ofertaCultural!.image1 ?? "",
      'clave2': widget.ofertaCultural!.image2 ?? "",
      'clave3': widget.ofertaCultural!.image3 ?? "",
    };

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: new AppBar(
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
          toolbarHeight: 150.0,
          title: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/logovert.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          backgroundColor: colorWhite,
        ),
      ),
      body: _container(context, miMapa),
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
          _redeSociales()
        ],
      ),
    );
  }

  Widget _bannerOfertaCultura(BuildContext context, Map<String, String> mapa) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView.builder(
        itemCount: mapa.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.height * 1,
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
          style: TextStyle(
            fontFamily: 'Klasik',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PrimaryBlackColors,
          )),
    );
  }

  Widget descripctionOfertaCulturalForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
      child: Text(widget.ofertaCultural!.description ?? "",
          style: TextStyle(
            fontSize: 16,
          )),
    );
  }

  Widget _fechaOfertaCultural(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: Column(
        children: [
          redesSocialesDrawer("assets/images/bless_ring.svg", 44, 44),
          SizedBox(height: 6.0),
          Text(
            parsearDateTime(widget.ofertaCultural!.fecha.toString()) ?? "",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _redeSociales(){
    return  Padding(
              padding: EdgeInsets.only(right: 20, bottom: 40, left: 10,top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => context.read<HomeCubit>().urlGlobal(widget.ofertaCultural!.facebook!),
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () =>context.read<HomeCubit>().urlGlobal(widget.ofertaCultural!.instagram!),
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                 
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () =>context.read<HomeCubit>().urlGlobal(widget.ofertaCultural!.whatsapp!),
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 40,
                      color: Color.fromRGBO(76, 175, 80, 1),
                    ),
                  ),
                ],
              ),
            );
  }
}
