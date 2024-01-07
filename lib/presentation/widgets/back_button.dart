
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget backButton(BuildContext context,Color color){
   return IconButton(
    onPressed: (){
      Navigator.pop(context);
    }, 
    icon: Icon(Icons.arrow_back_ios_new, color: color,)
    );
}