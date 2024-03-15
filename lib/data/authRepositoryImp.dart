import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRespositoryImpl implements AuthRespository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Users> login(String email, String password) async {
    try {
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Usuario')
          .doc(userCred.user!.uid)
          .get();

      Users usuario =
          Users.fromJson(docSnapshot.data() as Map<String, dynamic>);

      await UserPreferences.setPreference(
          usersUid, await getCurrentUserUid());

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

      await UserPreferences.setPreference(
          usersUid, await getCurrentUserUid());

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

  @override
  Future<String> getCurrentUserUid() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return "null";
    }
  }

    
  @override
  Future<void> resetPassword(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.sendPasswordResetEmail(email: email);
    // Muestra un mensaje de éxito
    print("El enlace para restablecer la contraseña ha sido enviado.");
  } on FirebaseAuthException catch (e) {
    // Manejo de errores, por ejemplo, si el usuario no existe
    print("Error al enviar el enlace de restablecimiento: ${e.message}");
  }
}
}
