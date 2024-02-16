import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/views/admin/directorio_artista/home_artista_directorio.dart';
import 'package:culturappco/presentation/views/admin/directorio_artista/home_categoria_directorio.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/utils/extensions/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDirectorioArtista extends StatefulWidget {
  const HomeDirectorioArtista({super.key});

  @override
  State<HomeDirectorioArtista> createState() => _HomeDirectorioArtistaState();
}

class _HomeDirectorioArtistaState extends State<HomeDirectorioArtista> {
  @override
  void initState() {
    super.initState();
  }

  int value = 0;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Directorio de artista'),
          backgroundColor: colorDirectorioArtista,
        ),
        drawer: drawer_menu(context, Colors.black),
        bottomNavigationBar:
            Container(color: Colors.white, child: _bottonBar()),
        body: Center(
            child: IndexedStack(index: value, children: [
              
          HomeCategoriaDirectorio(),
          HomeArtistaDirectorio()
        ])));
  }

  Widget _bottonBar() {
    int a;
    return GestureDetector(
      child: CustomAnimatedBottomBar(
          containerHeight: 60,
          backgroundColor: colorDirectorioArtista,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: value,
          onItemSelected: (index) => {
                a = index,
                setState(() {
                  value = a.toInt();
                }),
              },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.article_outlined),
              title: Text("Categoria"),
              activeColor: Colors.white,
              inactiveColor: kSecondaryColor,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.star),
              title: Text("Artista"),
              activeColor: Colors.white,
              inactiveColor: kSecondaryColor,
            ),
          ]),
    );
  }
}
