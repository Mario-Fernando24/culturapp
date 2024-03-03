import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/categoria_models.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRespository homeRespository;

  HomeCubit(this.homeRespository) : super(HomeInitial());

  Future<void> getProfile() async {
    String uidUsers = UserPreferences.getPreference(usersUid);

    final usuario = await homeRespository.getProfile(uidUsers);
    emit(UsuarioState(usuario));
  }

  Future<void> updateProfile(Users users) async {
    final status = await homeRespository.updateProfile(users);
    emit(HomeProfile(status));
  }

  Future selectImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    File? imageFile;

    XFile? imagen = await picker.pickImage(source: imageSource);

    emit(HomeLoading());

    if (imagen != null) {
      imageFile = File(imagen.path);
      emit(ImageFileProfile(imageFile,1));
    }
    // emit(HomeInitial());
  }

    Future selectImageOfertaCultural(ImageSource imageSource, int number) async {
    ImagePicker picker = ImagePicker();
    File? imageFile;

    XFile? imagen = await picker.pickImage(source: imageSource);

    emit(HomeLoading());

    if (imagen != null) {
      imageFile = File(imagen.path);
      emit(ImageFileProfile(imageFile,number));
    }
    // emit(HomeInitial());
  }


  Future<void> saveEvents(Evento evento, File? imageFile) async {
    try {
      emit(HomeLoading());
      final status = await homeRespository.saveEvento(evento, imageFile!);
      emit(EventAdd(status));
    } catch (e) {
      emit(EventAdd(false));
    }
  }

  Future<void> getEvents() async {
    try {
      emit(HomeInitial());
      emit(HomeLoading());
      final get_events = await homeRespository.getEvents("");
      emit(GetEvents(get_events));


    } catch (e) {
      emit(HomeInitial());
    }
  }


  Future<void> openGoogleMaps(double latitude, double longitude) async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
      launchUrl(url);
  }



Future<void> numeroEventos() async {
    try {
      final numEventos = await homeRespository.numeroEventos();
      emit(NumeroEventos(numEventos));


    } catch (e) {
      emit(HomeInitial());
    }
  }






  
  Future<void> urlGlobal(String urlEnpoind) async {
    print("############################################################################");
    print(urlEnpoind);
    print("############################################################################");
    final Uri url = Uri.parse(urlEnpoind.toString());
      launchUrl(url);
  }

  Future<void> updateEvents(String uidEvent, bool estado) async {
    emit(HomeInitial());
    try {
      emit(HomeLoading());
      final status = await homeRespository.updateEstadoEvents(uidEvent,estado);
      emit(EventUpdate(status));
    } catch (e) {
      emit(EventUpdate(false));
    }
  }


   Future<void> getCategoryEvent() async {
    emit(HomeInitial());
    try {
      emit(HomeLoading());
      // emit(GetCategoryEvents([]));
      
      final get_categoryEvents = await homeRespository.getCategoria();

      print("##############################################################################");
      print(get_categoryEvents.length);
      print("##############################################################################");
      emit(GetCategoryEvents(get_categoryEvents));

    } catch (e) {
      emit(HomeInitial());
    }
  }

  

  Future<void> saveCategoryEvents(CategoriaEvento categoriaEvento) async {
    emit(HomeInitial());
    try {
      emit(HomeLoading());
      final status = await homeRespository.saveCategoryEvents(categoriaEvento);
      emit(CategoryAdd(status));
    } catch (e) {
      emit(CategoryAdd(false));
    }
  }

    Future<void> saveDirectorioArtista(DirectorioArtista directorioArtista, File imageFile, File imageFile2, File imageFile3) async {
    emit(HomeInitial());
    try {
      emit(HomeLoading());
      final status = await homeRespository.saveDirectorioArtista(directorioArtista, imageFile, imageFile2, imageFile3);

      print("printttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
      print(status);
      print("printttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
      emit(OfertaCulturalAddState(status));
    } catch (e) {
      emit(OfertaCulturalAddState(false));
    }
  }


  
   Future<void> getDirectorioArtista() async {
    emit(HomeInitial());
    try {   
      final get_directorioArtista = await homeRespository.getDirectorioArtista();
      await Future.delayed(Duration(seconds: 3));
      emit(GetDirectorioArtista(get_directorioArtista));

    } catch (e) {
      emit(HomeInitial());
    }
  }




  Future<void> saveOfertaCultural(OfertaCultural ofertaCultural, File imageFile, File imageFile2, File imageFile3) async {
    emit(HomeInitial());
    try {
      emit(HomeLoading());
      final status = await homeRespository.saveOfertaCultural(ofertaCultural, imageFile, imageFile2, imageFile3);
      emit(OfertaCulturalAddState(status));
    } catch (e) {
      emit(OfertaCulturalAddState(false));
    }
  }

  
   Future<void> getOfertaCultural() async {
    emit(HomeInitial());
    try {
      emit(HomeLoading());
      
      final get_oferta_cultural = await homeRespository.getOfertaCultural();
      print("Ofertaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(get_oferta_cultural.length);
      print("Ofertaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      emit(GetOfertaCulturalEvents(get_oferta_cultural));

    } catch (e) {
      emit(HomeInitial());
    }
  }

  

}
