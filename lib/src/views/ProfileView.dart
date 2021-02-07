import 'package:flutter/material.dart';
import 'package:flutter_project/src/services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final tokenTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            context.read<AuthenticationService>().signOut();
          },
          child: Text("Sign out"),
        ),
        RaisedButton(
          onPressed: () async {
            await context.read<AuthenticationService>().generateToken();
          },
          child: Text("Generate token"),
        ),
        TextField(
          controller: tokenTextFieldController,
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16.0),
              hintText: "Token",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ),
        RaisedButton(
          onPressed: () async {
            await context.read<AuthenticationService>().checkToken(tokenTextFieldController.text);
          },
          child: Text("Check token"),
        ),
      ],
    );
  }
}