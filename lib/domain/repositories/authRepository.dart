import 'package:culturappco/domain/models/usuario.dart';

abstract class AuthRespository {
   
   Future<bool> login(String email, String password);
   Future<Users> register(Users users); 
   bool isSignedIn();
   Future<void> signOut();
}

//  // Users? getUser();
