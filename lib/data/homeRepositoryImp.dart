import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeRespositoryImpl implements HomeRespository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Users> getProfile(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('Usuario').doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final users = Users.fromJson(data);
        return users;
      } else {
        throw Exception('Perfil de usuario no encontrado.');
      }
    } catch (e) {
      // Manejar el error adecuadamente
      throw Exception('Error al obtener el perfil del usuario: $e');
    }
  }

  @override
  Future<bool> updateProfile(Users users) async {
    try {
      DocumentReference userReference =
          firestore.collection('Usuario').doc(users.uid);

      Map<String, dynamic> userData = {
        'username': users.username,
        'lastname': users.lastname,
        'telefono': users.telefono
      };

      await userReference.update(userData);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> saveEvento(Evento evento, File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("images/${DateTime.now().toIso8601String()}");

// Establecer los metadatos para el tipo de contenido
    SettableMetadata metadata = SettableMetadata(
      contentType:
          'image/jpeg', // Asegúrate de cambiar esto según el tipo de tu imagen (por ejemplo, 'image/png' para imágenes PNG)
    );

    await ref.putFile(file, metadata);
    final fileURL = await ref.getDownloadURL();

    evento.imagen = fileURL;
    evento.estado=true;
    evento.uidUsers=UserPreferences.getPreference(usersUid);

    try {
      DocumentReference docRef =
          await firestore.collection("eventos").add(evento.toJson());

      // ignore: unnecessary_null_comparison
      if (docRef.id != null) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
