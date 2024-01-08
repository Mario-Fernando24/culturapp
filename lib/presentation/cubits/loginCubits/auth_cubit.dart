import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:equatable/equatable.dart';
part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
 final AuthRespository authRespository;

  AuthenticationCubit(this.authRespository) : super(AuthenticationInitial());


  Future<void> logIn(String username, String password) async {
    emit(AuthenticationLoading());
    try {
      final user = await authRespository.login(username, password);
      emit(AuthenticationSuccessBoolean(user));
    } on Exception {
      emit(AuthenticationFailure());
    }
  }

  void logOut() {
    authRespository.signOut();
    emit(AuthenticationInitial());
  }
}
