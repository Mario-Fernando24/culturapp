import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/models/usuario.dart';

abstract class OfertasCulturalesRepository {

  Future<List<OfertaCultural>> getOfertaCultural(String search);

}
