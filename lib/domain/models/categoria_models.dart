import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CategoriaEvento categoriaEventoFromJson(String str) =>
    CategoriaEvento.fromJson(json.decode(str));

String categoriaEventoToJson(CategoriaEvento data) =>
    json.encode(data.toJson());

class CategoriaEvento {
  String name;
  String description;
  String uidUserIngresado;

  CategoriaEvento({
    required this.name,
    required this.description,
    required this.uidUserIngresado,
  });

  factory CategoriaEvento.fromJson(Map<String, dynamic> json) =>
      CategoriaEvento(
        name: json["name"],
        description: json["description"],
        uidUserIngresado: json["uid_user_ingresado"],
      );

  factory CategoriaEvento.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return CategoriaEvento(
      name: data["name"],
      description: data["description"],
      uidUserIngresado: data["uid_user_ingresado"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "uid_user_ingresado": uidUserIngresado,
      };
}
