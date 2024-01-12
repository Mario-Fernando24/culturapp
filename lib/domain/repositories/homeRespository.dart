
import 'package:culturappco/domain/models/usuario.dart';

abstract class HomeRespository {
   
   Future<Users> getProfile(String uid);
   
}
