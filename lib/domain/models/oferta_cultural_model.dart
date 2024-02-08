// To parse this JSON data, do
//
//     final ofertaCultural = ofertaCulturalFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

OfertaCultural ofertaCulturalFromJson(String str) =>
    OfertaCultural.fromJson(json.decode(str));

String ofertaCulturalToJson(OfertaCultural data) => json.encode(data.toJson());

class OfertaCultural {
  String? titleOfertaCultural;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  String? telefono;
  String? youtube;
  String? facebook;
  String? instagram;
  String? whatsapp;
  String? fecha;
  String? uid;

  OfertaCultural({
    this.titleOfertaCultural,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.telefono,
    this.youtube,
    this.facebook,
    this.instagram,
    this.whatsapp,
    this.fecha,
    this.uid
  });

  factory OfertaCultural.fromJson(Map<String, dynamic> json) => OfertaCultural(
        titleOfertaCultural: json["title_oferta_cultural"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        telefono: json["telefono"],
        youtube: json["youtube"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        whatsapp: json["whatsapp"],
        fecha: json["fecha"],
        uid: json["uid"],
      );

  factory OfertaCultural.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OfertaCultural(
      titleOfertaCultural: data["title_oferta_cultural"],
      description: data["description"],
      image1: data["image1"],
      image2: data["image2"],
      image3: data["image3"],
      telefono: data["telefono"],
      youtube: data["youtube"],
      facebook: data["facebook"],
      instagram: data["instagram"],
      whatsapp: data["whatsapp"],
      fecha: data["fecha"],
      uid: data["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title_oferta_cultural": titleOfertaCultural,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "telefono": telefono,
        "youtube": youtube,
        "facebook": facebook,
        "instagram": instagram,
        "whatsapp": whatsapp,
        "fecha":fecha,
        "uid": uid,
      };
}
