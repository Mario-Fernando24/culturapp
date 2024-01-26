import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class HomeRespositoryImpl implements HomeRespository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

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
    String uid = _uuid.v4();

    evento.imagen = fileURL;
    evento.estado = true;
    evento.uidEvento = uid;
    evento.uidUsers = UserPreferences.getPreference(usersUid);

    try {
      //var docRef =
      await firestore.collection('eventos').doc(uid).set(evento.toJson());
      // ignore: unnecessary_null_comparison
      //if (docRef != null) {
      return true;
      // } else {
      //   return false;
      // }
    } catch (error) {
      return false;
    }
  }

  @override
  Future<List<Evento>> getEvents() async {
    List<Evento> eventModelo = [];

    try {
      QuerySnapshot querySnapshot = await firestore.collection('eventos').get();

      eventModelo = querySnapshot.docs.map((doc) {
        return Evento.fromDocumentSnapshot(doc);
      }).toList();

      return eventModelo;
    } catch (e) {
      print('Error al obtener las products: $e');
      return eventModelo;
    }
  }

  @override
  Future<bool> updateEstadoEvents(String uidEvento, bool estado) async {
    try {
      
      bool estadoAux = false;
      if (estado) {
        estadoAux = false;
      } else {
        estadoAux = true;
      }
      firestore
          .collection('eventos')
          .doc(uidEvento)
          .update({'estado': estadoAux});

      return true;
    } catch (e) {
      return false;
    }
  }
}
