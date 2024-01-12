import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/authRepository.dart';
import 'package:culturappco/utils/error/errorMessage.dart';
import 'package:equatable/equatable.dart';
part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRespository authRespository;

  AuthenticationCubit(this.authRespository) : super(AuthenticationInitial());

  Future<void> loginCubit(String username, String password) async {
    try {
      emit(AuthenticationLoading());
      final user = await authRespository.login(username, password);

      emit(AuthenticationSuccess(user));
    } on Exception catch (e) {
      emit(AuthenticationFailure(extractErrorMessage(e.toString() ?? "")));
    } catch (e) {
      emit(AuthenticationFailure("An unexpected error occurred"));
    }
  }

  Future<void> register(Users users) async {
    try {
      emit(AuthenticationLoading());
      final user = await authRespository.register(users);
      // ignore: unnecessary_null_comparison
      emit(AuthenticationSuccess(user));
    } on Exception catch (e) {
      emit(AuthenticationFailure(extractErrorMessage(e.toString() ?? "")));
    } catch (e) {
      emit(AuthenticationFailure("An unexpected error occurred"));
    }
  }

  void logOut() {
    authRespository.signOut();
    emit(Unauthenticated());
  }
}
