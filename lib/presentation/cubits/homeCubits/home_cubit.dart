import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/error/errorMessage.dart';
import 'package:equatable/equatable.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRespository homeRespository;

  HomeCubit(this.homeRespository) : super(HomeInitial());

  Future<void> getProfile() async{
     final usuario =await homeRespository.getProfile('Obm1r5itY0hmttWQqx7jLc3gH4i2');
     emit(UsuarioState(usuario));
  }

}
