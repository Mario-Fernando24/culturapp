part of 'auth_cubit.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationSuccess extends AuthenticationState {
  final Users user;
  AuthenticationSuccess(this.user);
}
class AuthenticationSuccessBoolean extends AuthenticationState {
  final bool auth;
  AuthenticationSuccessBoolean(this.auth);
}
class AuthenticationFailure extends AuthenticationState {
  final String error;
  AuthenticationFailure(this.error);
}
