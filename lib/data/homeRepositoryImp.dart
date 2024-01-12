import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';

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

        print('00000000000000000000000000000000000000000000000000000000000000');
        print(users.telefono);
        print('00000000000000000000000000000000000000000000000000000000000000');
        return users;
      } else {
        throw Exception('Perfil de usuario no encontrado.');
      }
    } catch (e) {
      // Manejar el error adecuadamente
      throw Exception('Error al obtener el perfil del usuario: $e');
    }
  }
}
