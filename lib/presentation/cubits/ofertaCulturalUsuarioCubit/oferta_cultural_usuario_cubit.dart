import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/repositories/ofertasCulturalesRepository.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
part 'oferta_cultural_usuario_state.dart';

class OfertaCulturalUsuarioCubit extends Cubit<OfertaCulturalUsuarioState> {
  final OfertasCulturalesRepository ofertasCulturalesRepository;

  OfertaCulturalUsuarioCubit(this.ofertasCulturalesRepository) : super(OfertaCulturalInitial());

  
   Future<void> getOfertaCultural(String search) async {
    emit(OfertaCulturalInitial());
    try {
      emit(OfertaCulturaLoading());
      
      final get_oferta_cultural = await ofertasCulturalesRepository.getOfertaCultural(search);
      print("Ofertaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(get_oferta_cultural.length);
      print("Ofertaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      emit(GetOfertaCulturalEventUsuario(get_oferta_cultural));

    } catch (e) {
      emit(OfertaCulturalInitial());
    }
  }


   Future<void> downloadAndShareOfertaCultural(OfertaCultural ofertaCultural) async {
    try {
      //emit(UsuarioLoading());
      final Dio dio = Dio();
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/image.jpg';

      await dio.download(ofertaCultural.image1!.toString(), path);
      await Share.shareFiles([path],
          text:
              '*${ofertaCultural.titleOfertaCultural}* \n\n ${ofertaCultural.description}\n\n*Fecha:* ${parsearDateTime(ofertaCultural.fecha!)}');
      emit(OfertaCulturalInitial());
    } catch (e) {
      emit(OfertaCulturalInitial());
      print('Error downloading or sharing image: $e');
    }
  }


}
