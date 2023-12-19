part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

//penambahan state untuk login yang sukses

final class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse);
}

//state bila login gagal
final class LoginFailed extends LoginState {
  late final String message;

  LoginFailed(this.message);
}

//state saat login dalam proses

final class LoginInProgress extends LoginState {}
