import 'package:culturappco/config/themes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Color kPrimaryColor = Color(0xffFC9D45);
Color kSecondaryColor = Color(0xff573353);
Color inputColors = Color.fromRGBO(142, 142, 147, 1.2);

final kTitle = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
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

Widget redesSocialesDrawer(String directorio) {
  return SvgPicture.asset(
    directorio,
    width: 44.0,
    height: 44.0,
  );
}