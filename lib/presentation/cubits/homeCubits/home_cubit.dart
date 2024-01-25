import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/error/errorMessage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRespository homeRespository;

  HomeCubit(this.homeRespository) : super(HomeInitial());

  Future<void> getProfile() async {
    final usuario =
        await homeRespository.getProfile('Obm1r5itY0hmttWQqx7jLc3gH4i2');
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
  }


  Future<void> saveEvents(Evento evento, File? imageFile) async {
        final status = await homeRespository.saveEvento(evento,imageFile!);

  }
  
}
