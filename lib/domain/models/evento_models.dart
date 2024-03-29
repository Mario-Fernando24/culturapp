// To parse this JSON data, do
// https://app.quicktype.io/
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Evento eventoFromJson(String str) => Evento.fromJson(json.decode(str));

String eventoToJson(Evento data) => json.encode(data.toJson());

class Evento {
  String imagen;
  String tituloEvento;
  String descriptionEvento;
  String direccionEvento;
  String fechaEvento;
  double latitud;
  double longitud;
  bool  estado;
  String? uidUsers;
  String? uidEvento;

  Evento(
      {required this.imagen,
      required this.tituloEvento,
      required this.descriptionEvento,
      required this.direccionEvento,
      required this.fechaEvento,
      required this.latitud,
      required this.longitud,
      required this.estado,
      this.uidUsers,
      this.uidEvento});

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        imagen: json["imagen"],
        tituloEvento: json["titulo_evento"],
        descriptionEvento: json["description_evento"],
        direccionEvento: json["direccion_evento"],
        fechaEvento: json["fecha_evento"],
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
        estado: json["estado"],
        uidUsers: json["uid_users"],
        uidEvento: json["uidEvento"],
      );

  factory Evento.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Evento(
      imagen: data["imagen"],
      tituloEvento: data["titulo_evento"],
      descriptionEvento: data["description_evento"],
      direccionEvento: data["direccion_evento"],
      fechaEvento: data["fecha_evento"],
      latitud: data["latitud"]?.toDouble(),
      longitud: data["longitud"]?.toDouble(),
      estado: data["estado"],
      uidUsers: data["uid_users"],
      uidEvento: data["uidEvento"],
    );
  }

  Map<String, dynamic> toJson() => {
        "imagen": imagen,
        "titulo_evento": tituloEvento,
        "description_evento": descriptionEvento,
        "direccion_evento": direccionEvento,
        "fecha_evento": fechaEvento,
        "latitud": latitud,
        "longitud": longitud,
        "estado": estado,
        "uid_users": uidUsers,
        "uidEvento": uidEvento,
      };
}
