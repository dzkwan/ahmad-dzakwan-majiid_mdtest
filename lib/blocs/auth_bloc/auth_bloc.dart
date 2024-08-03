import 'package:fan_test/blocs/auth_bloc/bloc.dart';
import 'package:fan_test/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<SendEmailVerifEvent>(_sendEmailVerif);
    on<CheckEmailVerifEvent>(_checkEmailVerif);
    on<ResetPasswordEvent>(_resetPassword);
  }
}

Future<void> _login(
  LoginEvent event,
  Emitter<AuthState> emit,
) async {
  debugPrint("Login BLoC");

  AuthService apiProvider = AuthService();

  emit(LoginLoaded());

  try {
    var data = await apiProvider.signInUser(
        email: event.email, password: event.password);
    if (data.success != null) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailed(
        message: "${data.error?.message}",
      ));
    }
  } catch (e) {
    debugPrint("Error in Bloc-feat(login): $e");
  }
}

Future<void> _register(
  RegisterEvent event,
  Emitter<AuthState> emit,
) async {
  debugPrint("Register BLoC");

  AuthService apiProvider = AuthService();

  emit(RegisterLoaded());

  try {
    var dataSignUp = await apiProvider.signUpUser(
        nama: event.nama, email: event.email, password: event.password);

    // await Future.delayed(Durations.medium2);

    if (dataSignUp.success != null) {
      var dataEmailVerif = await apiProvider.sendVerificationEmail();
      if (dataEmailVerif.success != null) {
        emit(RegisterSuccess());
      }
    } else {
      emit(RegisterFailed(
        message: "${dataSignUp.error?.message}",
      ));
    }
  } catch (e) {
    debugPrint("Error in Bloc-feat(register): $e");
  }
}

Future<void> _sendEmailVerif(
  SendEmailVerifEvent event,
  Emitter<AuthState> emit,
) async {
  debugPrint("sendEmailVerif BLoC");

  AuthService apiProvider = AuthService();

  emit(SendEmailVerifLoaded());

  try {
    var data = await apiProvider.sendVerificationEmail();
    if (data.success != null) {
      emit(SendEmailVerifSuccess());
    }
    if (data.error != null) {
      emit(SendEmailVerifFailed(message: "${data.error?.message}"));
    }
  } catch (e) {
    debugPrint("Error in Bloc-feat(sendEmailVerif): $e");
  }
}

Future<void> _checkEmailVerif(
  CheckEmailVerifEvent event,
  Emitter<AuthState> emit,
) async {
  debugPrint("checkEmailVerif BLoC");

  AuthService apiProvider = AuthService();

  emit(CheckEmailVerifLoaded());

  try {
    var data = await apiProvider.checkEmailVerificationAndUpdate();
    if (data == null) {
      emit(CheckEmailVerifSuccess());
    } else {
      emit(CheckEmailVerifFailed(message: "${data.message}"));
    }
  } catch (e) {
    debugPrint("Error in Bloc-feat(sendEmailVerif): $e");
  }
}

Future<void> _resetPassword(
  ResetPasswordEvent event,
  Emitter<AuthState> emit,
) async {
  debugPrint("resetPassword BLoC");

  AuthService apiProvider = AuthService();

  emit(ResetPasswordLoaded());

  try {
    var data = await apiProvider.resetPassword(event.email);
    if (data.success) {
      emit(ResetPasswordSuccess());
    } else {
      emit(ResetPasswordFailed(message: "${data.error?.message}"));
    }
  } catch (e) {
    debugPrint("Error in Bloc-feat(resetPassword): $e");
  }
}
