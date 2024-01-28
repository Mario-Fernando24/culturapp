import 'dart:io';

import 'package:culturappco/domain/models/categoria_models.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/usuario.dart';

abstract class HomeRespository {
  Future<Users> getProfile(String uid);
  Future<bool> updateProfile(Users users);
  Future<bool> saveEvento(Evento evento, File file);
  Future<List<Evento>> getEvents();
  Future<bool> updateEstadoEvents(String uidEvento, bool estado);

  //Categoria
  Future<List<CategoriaEvento>> getCategoria();
  Future<bool> saveCategoryEvents(CategoriaEvento categoriaEvento);
}
