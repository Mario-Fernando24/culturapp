import 'package:culturappco/domain/models/usuario.dart';

abstract class HomeRespository {
   
   Future<void> getProfile(String uid);
   
}
