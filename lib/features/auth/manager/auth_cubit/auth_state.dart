part of 'auth_cubit.dart';
@immutable

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errMsg;

  LoginFailure({required this.errMsg});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errMsg;

  RegisterFailure({required this.errMsg});
}
