abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoginFailed extends AuthState {
  final String message;

  LoginFailed({required this.message});
}

class LoginLoaded extends AuthState {}

class LoginSuccess extends AuthState {}

class RegisterFailed extends AuthState {
  final String message;

  RegisterFailed({required this.message});
}

class RegisterLoaded extends AuthState {}

class RegisterSuccess extends AuthState {}

class SendEmailVerifFailed extends AuthState {

  final String message;

  SendEmailVerifFailed({required this.message});
}

class SendEmailVerifLoaded extends AuthState {}

class SendEmailVerifSuccess extends AuthState {}

class ResetPasswordFailed extends AuthState {

  final String message;

  ResetPasswordFailed({required this.message});
}

class ResetPasswordLoaded extends AuthState {}

class ResetPasswordSuccess extends AuthState {}
class CheckEmailVerifFailed extends AuthState {

  final String message;

  CheckEmailVerifFailed({required this.message});
}

class CheckEmailVerifLoaded extends AuthState {}

class CheckEmailVerifSuccess extends AuthState {}
