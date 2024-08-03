abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent({required this.email, required this.password});
  final String email;
  final String password;
}

class RegisterEvent extends AuthEvent {
  RegisterEvent(
      {required this.nama, required this.email, required this.password});
  final String nama;
  final String email;
  final String password;
}

class SendEmailVerifEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  ResetPasswordEvent({required this.email});
  final String email;
}

class CheckEmailVerifEvent extends AuthEvent {}
