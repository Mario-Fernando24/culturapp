import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsersDirectorioDetails extends StatefulWidget {

  final DirectorioArtista? directorioArtista;

  UsersDirectorioDetails({required this.directorioArtista});


  @override
  State<UsersDirectorioDetails> createState() => _UsersDirectorioDetailsState();
}

class _UsersDirectorioDetailsState extends State<UsersDirectorioDetails> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> miMapa = {
      'clave1': widget.directorioArtista!.image1 ?? "",
      'clave2': widget.directorioArtista!.image2 ?? "",
      'clave3': widget.directorioArtista!.image3 ?? "",
    };
    print(miMapa.toString());

    return Scaffold(
       appBar: AppBar(
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
      toolbarHeight: 70.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Alinea el contenido al final (derecha)
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logovert.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
     ),
      body: _container(context, miMapa),
    );
  }

  Widget _container(BuildContext context, Map<String, String> mapa) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         _bannerOfertaCultura(context, mapa),
         titleOfertaCulturalForm(),
         descripctionOfertaCulturalForm(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          contactosIconos(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }

  Widget _bannerOfertaCultura(BuildContext context, Map<String, String> mapa) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: PageView.builder(
        itemCount: mapa.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.height  * 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // ignore: unnecessary_null_comparison
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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15, left: 15),
          child: Text(widget.directorioArtista!.name ?? "",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
        ),
        Container(
          margin: EdgeInsets.only(  right: 15, left: 15),
          child: Text(widget.directorioArtista!.categoria ?? "",
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  Widget descripctionOfertaCulturalForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15, top: 10),
      child: Text(widget.directorioArtista!.descripcion ?? "",
          style: TextStyle(
            fontSize: 14
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
              size: 50,
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
              size: 50,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}