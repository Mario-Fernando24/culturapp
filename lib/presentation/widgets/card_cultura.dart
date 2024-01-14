import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:flutter/material.dart';

Widget cardCultura(
    BuildContext context,
    double margintop,
    double marginrigth,
    double marginBotton,
    double marginLetf,
    String photo,
    String title,
    String subtitle,
    String direccion,
    String buttonText) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(
            top: margintop,
            right: marginrigth,
            bottom: marginBotton,
            left: marginLetf),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(photo),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 7.0),
                      child: headerText(
                          title ?? '', Colors.black, FontWeight.bold, 17.0)),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      subtitle ?? '',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, color: Colors.red, size: 20.0),
                      Text(
                        'direccion' ?? '',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      
                      Container(
                          margin: EdgeInsets.only(left: 90),
                          width: 80.0,
                          height: 26.0,
                          child: buttonText.length > 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.5,
                                    shape: StadiumBorder(),
                                    primary: kPrimaryColor,
                                    onPrimary: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Text(buttonText,
                                      style: TextStyle(fontSize: 11.0)),
                                )
                              : Text(""))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}
