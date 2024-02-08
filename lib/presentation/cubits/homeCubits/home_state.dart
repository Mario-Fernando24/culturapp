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

class HomeProfile extends HomeState {
  final bool status;
  HomeProfile(this.status);
}

class ImageFileProfile extends HomeState {
  final File? imageFile;
  final int? numImagen;
  ImageFileProfile(this.imageFile, this.numImagen);
}

class EventAdd extends HomeState {
  final bool status;
  EventAdd(this.status);
}

class EventUpdate extends HomeState {
  final bool status;
  EventUpdate(this.status);
}


class GetEvents extends HomeState {
  final List<Evento> listEvents;
  GetEvents(this.listEvents);
}

class GetCategoryEvents extends HomeState {
  final List<CategoriaEvento> listCategoryEvents;
  GetCategoryEvents(this.listCategoryEvents);
}

class CategoryAdd extends HomeState {
  final bool status;
  CategoryAdd(this.status);
}

class OfertaCulturalAddState extends HomeState {
  final bool status;
  OfertaCulturalAddState(this.status);
}

class GetOfertaCulturalEvents extends HomeState {
  final List<OfertaCultural> listOferaCultural;
  GetOfertaCulturalEvents(this.listOferaCultural);
}
