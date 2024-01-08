import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String ?uid;
  String ?username;
  String ?lastname;
  String ?email;
  String ?telefono;
  String ?password;
  String ?token;

  Users({
    this.uid,
    this.username,
    this.lastname,
    this.email,
    this.telefono,
    this.password,
    this.token,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"],
        username: json["username"],
        lastname: json["lastname"],
        email: json["email"],
        telefono: json["telefono"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "lastname": lastname,
        "email": email,
        "telefono": telefono,
        "token": token,
      };
}