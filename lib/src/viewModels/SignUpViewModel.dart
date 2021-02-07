import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import '../services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class SignUpViewModel {
  var _emailController = StreamController<String>.broadcast();
  var _passwordController = StreamController<String>.broadcast();
  var _passwordConfirmationController = StreamController<String>.broadcast();

  Sink get inputEmailText => _emailController;
  Sink get inputPasswordText => _passwordController;
  Sink get inputPasswordConfirmationText => _passwordConfirmationController;

  Stream<bool> get outputIsLoginButtonEnabled => _emailController.stream.map((email) {
    return EmailValidator.validate(email);
  });

  Stream<String> get outputErrorText => outputIsLoginButtonEnabled.map((isEnabled) => isEnabled ? null : "Invalid e-mail");


  void dispose() {
    _emailController.close();
    _passwordController.close();
    _passwordConfirmationController.close();
  }

  void signUp({BuildContext context, String email, String password}) {
    context.read<AuthenticationService>().signUp(email: email, password: password);
  }

  void googleSignIn({BuildContext context}) {
    context.read<AuthenticationService>().signInWithGoogle();
  }

}