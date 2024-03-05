part of 'oferta_cultural_usuario_cubit.dart';

abstract class OfertaCulturalUsuarioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OfertaCulturalInitial extends OfertaCulturalUsuarioState {}
class OfertaCulturaLoading extends OfertaCulturalUsuarioState {}
class OfertaCulturaUnauthenticated extends OfertaCulturalUsuarioState {}

class GetOfertaCulturalEventUsuario extends OfertaCulturalUsuarioState {
  final List<OfertaCultural> listOferaCultural;
  GetOfertaCulturalEventUsuario(this.listOferaCultural);
}




