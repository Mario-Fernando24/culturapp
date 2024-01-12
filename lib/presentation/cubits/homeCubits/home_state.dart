part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class Unauthenticated extends HomeState {}

class UsuarioState extends HomeState {
  final Users user;
  UsuarioState(this.user);
}
class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}
