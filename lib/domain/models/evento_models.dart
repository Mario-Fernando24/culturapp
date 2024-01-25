// To parse this JSON data, do
// https://app.quicktype.io/
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

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
    String uidUsers;

    Evento({
        required this.imagen,
        required this.tituloEvento,
        required this.descriptionEvento,
        required this.direccionEvento,
        required this.fechaEvento,
        required this.latitud,
        required this.longitud,
        required this.uidUsers,
    });

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        imagen: json["imagen"],
        tituloEvento: json["titulo_evento"],
        descriptionEvento: json["description_evento"],
        direccionEvento: json["direccion_evento"],
        fechaEvento: json["fecha_evento"],
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
        uidUsers: json["uid_users"],
    );

    Map<String, dynamic> toJson() => {
        "imagen": imagen,
        "titulo_evento": tituloEvento,
        "description_evento": descriptionEvento,
        "direccion_evento": direccionEvento,
        "fecha_evento": fechaEvento,
        "latitud": latitud,
        "longitud": longitud,
        "uid_users": uidUsers,
    };
}
