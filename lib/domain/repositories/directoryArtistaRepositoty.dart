import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/models/usuario.dart';

abstract class DirectoryArtistaRepository {

  Future<List<DirectorioArtista>> getDirectorioArtista(String search, String parametro);
  Future<String> getCurrentUserUid();

}
