import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRespositoryImpl implements AuthRespository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Users> login(String email, String password) async {
    try {

      
          print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
          print(email);
          print(password);
          print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

          print("***********************************************************************");
          print(userCred.user!.email);
          print(userCred.user!.uid);
          print("***********************************************************************");
      // ignore: unnecessary_null_comparison

      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Usuario')
          .doc(userCred.user!.uid)
          .get();

      Users usuario =
          Users.fromJson(docSnapshot.data() as Map<String, dynamic>);

      return usuario;
    } catch (e) {
      return throw Exception('$e');
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

      final users = Users(
          uid: userCredential.user!.uid,
          username: usuario.username,
          lastname: usuario.lastname,
          email: usuario.email,
          telefono: usuario.telefono,
          rol: rolUser);
      await FirebaseFirestore.instance
          .collection('Usuario')
          .doc(userCredential.user!.uid)
          .set(users.toJson());

      return users;
    } catch (e) {
      return throw Exception('$e');
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
