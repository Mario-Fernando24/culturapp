part of 'directory_artista_usuario_cubit.dart';

abstract class DirectorioArtistaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DirectorioArtistaInitial extends DirectorioArtistaState {}
class DirectorioArtistaLoading extends DirectorioArtistaState {}
class DirectorioArtistaUnauthenticated extends DirectorioArtistaState {}

class GetOfertaDirectorioArtistaUsuario extends DirectorioArtistaState {

  final List<DirectorioArtista> listDirectorioArtista;
  GetOfertaDirectorioArtistaUsuario(this.listDirectorioArtista);

}

class GetCurrentUsers extends DirectorioArtistaState {
  final String currentUsers;
  GetCurrentUsers(this.currentUsers);
}





