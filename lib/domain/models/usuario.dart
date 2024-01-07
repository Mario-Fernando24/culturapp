import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String ?uid;
  String ?username;
  String ?email;
  String ?telefono;
  String ?password;
  String ?token;

  Users({
    this.uid,
    this.username,
    this.email,
    this.telefono,
    this.password,
    this.token,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        telefono: json["telefono"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "telefono": telefono,
        "token": token,
      };
}