import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/widgets/card_cultura.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class AgendaCulturalList extends StatefulWidget {
  const AgendaCulturalList({super.key});

  @override
  State<AgendaCulturalList> createState() => _AgendaCulturalListState();
}

class _AgendaCulturalListState extends State<AgendaCulturalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Agenda cultural'),
      ),
      drawer: drawer_menu(context, Colors.black),
      body: _listAgendaCultural(),
    );
  }

  Widget _listAgendaCultural() {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              children: [
                _headers(context, "Agenda cultural ", "Agregar evento"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
                cardCultura(
                    context,
                    0.0,
                    0.0,
                    0.0,
                    10.0,
                    "https://www.eltiempo.com/files/article_multimedia/uploads/2021/01/04/5ff303f43717f.jpeg",
                    "Evento cultural",
                    "es un evento familiar textHeader",
                    "direccion",
                    "Detalle"),
              ],
            ),
          )
        ]))
      ],
    ));
  }

  Widget _headers(BuildContext context, String textHeader, String textAction) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: headerText(textHeader, Colors.black, FontWeight.bold, 20.0),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, addAgendaCulturalviewRoutes),
          child: Row(
            children: [
              Text(
                textAction,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
              Container(
                width: 30.0,
                height: 30.0,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderCollections() {
    return Container(
      height: 200.0,
      child: Swiper(
          itemCount: 4,
          layout: SwiperLayout.DEFAULT,
          itemBuilder: (BuildContext context, int index) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return _tarjetaCollections(context);
                });
          }),
    );
  }

  Widget _tarjetaCollections(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              width: 300,
              height: 150,
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8Zm9vZHxlbnwwfDF8MHw%3D&auto=format&fit=crop&w=500&q=60"),
            ),
          ),
        ],
      ),
    );
  }
}
