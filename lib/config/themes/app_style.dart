import 'package:culturappco/config/themes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Color kPrimaryColor = Color(0xffEE8235);
Color kSecondaryColor = Color(0xff71C7E3);
Color inputColors = Color.fromRGBO(142, 142, 147, 1.2);
final PrimaryGreyColors = Color(0xFFBCB9B7); 
final PrimaryBlackColors = Color.fromARGB(255, 20, 19, 19); 

final colorDirectorioArtista=Color(0xff71C7E3);
final colorAgendaCultural=Color(0xffF9B539);
final colorOfertaCultural=Color(0xffDADB19);
final colorWhite = Colors.white;


final kTitle = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kTitleBlackcolor = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: PrimaryBlackColors,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);

final kBodyText2 = TextStyle(
  color: kPrimaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);

Widget redesSocialesDrawer(String directorio, double width ,double height) {
  return SvgPicture.asset(
    directorio,
    width: width,
    height: height,
  );
}