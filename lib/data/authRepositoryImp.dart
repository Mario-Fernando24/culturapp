import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRespositoryImpl implements AuthRespository {
  
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (userCred.user!.uid != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  @override
  Future<Users> register(Users usuario) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.password!,
      );

      Users users = Users(uid: userCredential.user!.uid);
      await FirebaseFirestore.instance
          .collection('Usuario')
          .doc(userCredential.user!.uid)
          .set(users.toJson());

      return users;
    } catch (e) {
      print('Error en el registro: $e');
      return throw Exception('Error en el registro :$e');
    }
  }

  @override
  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return false;
    }
    return true;
  }

  Future signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  // Users? getUser() {
  //   return _firebaseAuth.currentUser;
  // }
}
