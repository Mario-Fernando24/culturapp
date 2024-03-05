import 'package:culturappco/config/themes/app_style.dart';
import 'package:flutter/material.dart';

class UsersDirectorioDetails extends StatefulWidget {
  const UsersDirectorioDetails({super.key});

  @override
  State<UsersDirectorioDetails> createState() => _UsersDirectorioDetailsState();
}

class _UsersDirectorioDetailsState extends State<UsersDirectorioDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Detalles de Artista'),
          backgroundColor: colorDirectorioArtista,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )
         ),
    );
  }
}