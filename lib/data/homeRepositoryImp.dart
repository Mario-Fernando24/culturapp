import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRespositoryImpl implements HomeRespository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> getProfile(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('Usuario').doc(uid).get();

      if (documentSnapshot.exists) {
        print(
            '=================================================================================');
        print(documentSnapshot.data());
        print(
            '=================================================================================');
      } else {
        throw Exception('Perfil de usuario no encontrado.');
      }
    } catch (e) {
      // Manejar el error adecuadamente
      throw Exception('Error al obtener el perfil del usuario: $e');
    }
  }
}
