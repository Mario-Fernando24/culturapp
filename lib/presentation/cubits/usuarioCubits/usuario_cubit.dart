import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:equatable/equatable.dart';
part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioCubitState> {
  final HomeRespository homeRespository;

  UsuarioCubit(this.homeRespository) : super(UsuarioInitial());

  Future<void> getEventsUsuario() async {
    try {

       emit(UsuarioInitial());
    //   emit(UsuarioLoading());
      final get_events = await homeRespository.getEvents();
      print(get_events.toString());
      emit(GetEventsUsuario(get_events));

    } catch (e) {
      emit(UsuarioInitial());
    }
  }

  Future<void> downloadAndShare(Evento evento) async {
  try {
    emit(UsuarioLoading());
    final Dio dio = Dio();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/image.jpg';

    await dio.download(evento.imagen, path);
    await Share.shareFiles([path], text: '*${evento.tituloEvento}* \n\n ${evento.descriptionEvento}\n\n*Fecha:* ${parsearDateTime(evento.fechaEvento)}');
    emit(UsuarioInitial());
  } catch (e) {
     emit(UsuarioInitial());
    print('Error downloading or sharing image: $e');
  }
}

  
  
}
