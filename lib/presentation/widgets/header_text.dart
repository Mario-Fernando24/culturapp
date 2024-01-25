import 'package:culturappco/config/themes/app_style.dart';
import 'package:flutter/material.dart';

Widget headerText(String text, Color color, fontWeight, double fontsize, TextAlign textAlign) {
  return Text(
    text,textAlign: textAlign,
    style: TextStyle(
        color:color, fontWeight: fontWeight, fontSize: fontsize),
  );
}


Widget titleForm(String title) {
  return Container(
    margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 0.0),
    child: Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: kSecondaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
