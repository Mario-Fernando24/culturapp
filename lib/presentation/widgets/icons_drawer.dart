import 'package:flutter/material.dart';

Widget iconDrawer(String urlImagen, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 0.15,
    height: MediaQuery.of(context).size.height * 0.078,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(urlImagen),
        fit: BoxFit.fill,
      ),
    ),
  );
}
