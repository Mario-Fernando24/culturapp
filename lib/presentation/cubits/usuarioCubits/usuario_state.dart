part of 'usuario_cubit.dart';

abstract class UsuarioCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsuarioInitial extends UsuarioCubitState {}
class UsuarioLoading extends UsuarioCubitState {}
class Unauthenticated extends UsuarioCubitState {}


class GetEventsUsuario extends UsuarioCubitState {
  final List<Evento> listEvents;
  GetEventsUsuario(this.listEvents);
}

