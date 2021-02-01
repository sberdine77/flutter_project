import 'package:flutter/material.dart';
import '../viewModels/LoginViewModel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
    final emailTextFieldController = TextEditingController();
    final passwordTextFieldController = TextEditingController();

    var _viewModel = new LoginViewModel();

    @override
    void initState() {
      emailTextFieldController.addListener(() {
        _viewModel.inputEmailText.add(emailTextFieldController.text);
      });
      passwordTextFieldController.addListener(() => _viewModel.inputPasswordText.add(passwordTextFieldController.text));
      super.initState();
    }

    @override
    void dispose() {
      emailTextFieldController.dispose();
      passwordTextFieldController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding:  const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<String>(
                  stream: _viewModel.outputErrorText,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: emailTextFieldController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16.0),
                            hintText: "E-mail",
                            errorText: snapshot.data,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: passwordTextFieldController,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16.0),
                        hintText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    onPressed: () {
                      _viewModel.signIn(context: context, email: emailTextFieldController.text, password: passwordTextFieldController.text);
                    },
                    child: Text("Sign in"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}