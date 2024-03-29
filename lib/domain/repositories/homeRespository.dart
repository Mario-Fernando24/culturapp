import 'dart:io';

import 'package:culturappco/domain/models/categoria_models.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/models/usuario.dart';

abstract class HomeRespository {
  Future<Users> getProfile(String uid);
  Future<bool> updateProfile(Users users);
  Future<bool> saveEvento(Evento evento, File file);
  Future<List<Evento>> getEvents(String search);
  Future<bool> updateEstadoEvents(String uidEvento, bool estado);

  Future<List<String>> numeroEventos();

  //Categoria
  Future<List<CategoriaEvento>> getCategoria();
  Future<bool> saveDirectorioArtista(DirectorioArtista directorioArtista, File file1, File file2, File file3);
  Future<List<DirectorioArtista>> getDirectorioArtista();

  
  Future<bool> saveCategoryEvents(CategoriaEvento categoriaEvento);

  //Oferta cultural
  Future<bool> saveOfertaCultural(OfertaCultural ofertaCultural, File file1, File file2, File file3);
  Future<List<OfertaCultural>> getOfertaCultural();

  
}
