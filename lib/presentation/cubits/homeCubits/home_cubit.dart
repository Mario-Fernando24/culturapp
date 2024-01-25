import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/evento_models.dart';
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
      emit(ImageFileProfile(imageFile));
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
      final get_events = await homeRespository.getEvents();
      emit(GetEvents(get_events));


    } catch (e) {
      emit(HomeInitial());
    }
  }


  Future<void> openGoogleMaps(double latitude, double longitude) async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
      launchUrl(url);
  }

}
