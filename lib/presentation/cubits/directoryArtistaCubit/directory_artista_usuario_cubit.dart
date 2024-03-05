import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/repositories/directoryArtistaRepositoty.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
part 'directory_artista_usuario_state.dart';

class DirectoryArtistaCubit extends Cubit<DirectorioArtistaState> {
  final DirectoryArtistaRepository directoryArtistaRepository;

  DirectoryArtistaCubit(this.directoryArtistaRepository)
      : super(DirectorioArtistaInitial());

  Future<void> getDirectorioArtista(String search, String parametro) async {
    emit(DirectorioArtistaInitial());
    try {
      emit(DirectorioArtistaLoading());

      final get_directorio_artista = await directoryArtistaRepository
          .getDirectorioArtista(search, parametro);
      print(
          "Ofertaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(get_directorio_artista.length);
      print(
          "Ofertaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      emit(GetOfertaDirectorioArtistaUsuario(get_directorio_artista));
    } catch (e) {
      emit(DirectorioArtistaInitial());
    }
  }

  Future<void> downloadAndShareOfertaCultural(
      DirectorioArtista ofertaCultural) async {
    try {
      //emit(UsuarioLoading());
      final Dio dio = Dio();
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/image.jpg';

      await dio.download(ofertaCultural.image1!.toString(), path);
      await Share.shareFiles([path],
          text:
              '*${ofertaCultural.name}* \n\n ${ofertaCultural.descripcion}\n\n*Fecha:*');
      emit(DirectorioArtistaInitial());
    } catch (e) {
      emit(DirectorioArtistaInitial());
      print('Error downloading or sharing image: $e');
    }
  }

  Future<String> getCurrent() async {
    try {
      emit(DirectorioArtistaInitial());

      final getCurrentUsers =
          await directoryArtistaRepository.getCurrentUserUid();

      emit(GetCurrentUsers(getCurrentUsers));
      return getCurrentUsers;
    } catch (e) {
      emit(DirectorioArtistaInitial());
      return 'null';
      print('Error downloading or sharing image: $e');
    }
  }
}
