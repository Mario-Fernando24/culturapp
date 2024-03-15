import 'package:culturappco/domain/models/usuario.dart';

abstract class AuthRespository {
  Future<Users> login(String email, String password);
  Future<Users> register(Users users);
  Future<void> resetPassword(String email);
  bool isSignedIn();
  Future<void> signOut();
  Future<String> getCurrentUserUid();
  
}
