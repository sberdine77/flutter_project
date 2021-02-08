import 'package:flutter/material.dart';
import 'package:flutter_project/src/services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class TokenView extends StatefulWidget {
  @override
  _TokenViewState createState() => _TokenViewState();
}

class _TokenViewState extends State<TokenView> {

  final tokenTextFieldController = TextEditingController();
  String _tokenHint = "Token";
  bool _isTokenSended = false;

  @override
  Widget build(BuildContext context) {
    return  ListView(
        children: <Widget>[
          Container(
            child: _isTokenSended ? TextField(
              controller: tokenTextFieldController,
              obscureText: false,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  hintText: "Token",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
            )
                :
            null,
          ),
          Container(
            child: _isTokenSended ? RaisedButton(
              onPressed: () async {
                var response = await context.read<AuthenticationService>().checkToken(tokenTextFieldController.text);
                if(response.statusCode == 200) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  tokenTextFieldController.text = "";
                  _tokenHint = "Try again";
                }
              },
              child: Text("Check token"),
            )
                :
            null,
          ),
          Spacer(),
          RaisedButton(
            onPressed: _isTokenSended ? () async {
              var response = await context.read<AuthenticationService>().generateToken();
              if(response.statusCode == 200) {
                setState(() {
                  _isTokenSended = true;
                });
              }
            }
            : () async {
              var response = await context.read<AuthenticationService>().generateToken();
              if(response.statusCode == 200) {
                setState(() {
                  _isTokenSended = true;
                });
              }
            },
            child: Text(_isTokenSended ? "Send token again" : "Generate token"),
          ),
        ]);
  }

}