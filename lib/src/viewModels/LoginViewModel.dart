import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import '../services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class LoginViewModel {
  var _emailTextFieldController = StreamController<String>.broadcast();
  var _passwordTextFieldController = StreamController<String>.broadcast();

  Sink get inputEmailText => _emailTextFieldController;
  Sink get inputPasswordText => _passwordTextFieldController;

  Stream<bool> get outputIsLoginButtonEnabled => _emailTextFieldController.stream.map((email) => EmailValidator.validate(email));
  Stream<String> get outputErrorText => outputIsLoginButtonEnabled.map((isEnabled) => isEnabled ? null : "Invalid e-mail");

  void dispose() {
    _emailTextFieldController.close();
    _passwordTextFieldController.close();
  }

  void signIn({BuildContext context, String email, String password}) {
    context.read<AuthenticationService>().signIn(email: email, password: password);
  }

  void googleSignIn({BuildContext context}) {
    context.read<AuthenticationService>().signInWithGoogle();
  }

}