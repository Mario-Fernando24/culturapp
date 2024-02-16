// To parse this JSON data, do
//
//     final directorioArtista = directorioArtistaFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

DirectorioArtista directorioArtistaFromJson(String str) => DirectorioArtista.fromJson(json.decode(str));

String directorioArtistaToJson(DirectorioArtista data) => json.encode(data.toJson());

class DirectorioArtista {
    String ?categoria;
    String ?idCategoria;
    String ?image1;
    String ?image2;
    String ?image3;
    String ?name;
    String ?descripcion;
    String ?facebook;
    String ?instagram;
    String ?uid;

    DirectorioArtista({
        this.categoria,
        this.idCategoria,
        this.image1,
        this.image2,
        this.image3,
        this.name,
        this.descripcion,
        this.facebook,
        this.instagram,
        this.uid
    });

    factory DirectorioArtista.fromJson(Map<String, dynamic> json) => DirectorioArtista(
        categoria: json["categoria"],
        idCategoria: json["id_categoria"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        name: json["name"],
        descripcion: json["descripcion"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        uid: json["uid"],

    );

    factory DirectorioArtista.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return DirectorioArtista(
         categoria: data["categoria"],
        idCategoria: data["id_categoria"],
        image1: data["image1"],
        image2: data["image2"],
        image3: data["image3"],
        name: data["name"],
        descripcion: data["descripcion"],
        facebook: data["facebook"],
        instagram: data["instagram"],
        uid: data["uid"],
    );
  }

    Map<String, dynamic> toJson() => {
        "categoria": categoria,
        "id_categoria": idCategoria,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "name": name,
        "descripcion": descripcion,
        "facebook": facebook,
        "instagram": instagram,
        "uid": uid,

    };
}
