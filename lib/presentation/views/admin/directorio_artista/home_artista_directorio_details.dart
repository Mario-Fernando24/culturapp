import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeArtistaDirectorioDetails extends StatefulWidget {
  final DirectorioArtista? directorioArtista;

  HomeArtistaDirectorioDetails({required this.directorioArtista});

  @override
  State<HomeArtistaDirectorioDetails> createState() =>
      _HomeArtistaDirectorioDetailsState();
}

class _HomeArtistaDirectorioDetailsState
    extends State<HomeArtistaDirectorioDetails> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> miMapa = {
      'clave1': widget.directorioArtista!.image1 ?? "",
      'clave2': widget.directorioArtista!.image2 ?? "",
      'clave3': widget.directorioArtista!.image3 ?? "",
    };

    return Scaffold(
      appBar: AppBar(
          title: Text('Detalles de Artista'),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )),
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.20),
          contactosIconos(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
      child: Text(widget.directorioArtista!.facebook ?? "",
          style: kTitleBlackcolor),
    );
  }

  Widget descripctionOfertaCulturalForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
      child: Text(widget.directorioArtista!.descripcion ?? "",
          style: TextStyle(
            fontSize: 18,
          )),
    );
  }

  Widget contactosIconos() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 40, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<HomeCubit>()
                  .urlGlobal(widget.directorioArtista!.facebook.toString());
            },
            child: FaIcon(
              FontAwesomeIcons.facebook,
              size: 90,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              context
                  .read<HomeCubit>()
                  .urlGlobal(widget.directorioArtista!.instagram.toString());
            },
            child: FaIcon(
              FontAwesomeIcons.instagram,
              size: 90,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
