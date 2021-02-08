import 'package:flutter/material.dart';
import 'package:flutter_project/src/services/AuhtenticationService.dart';
import 'package:flutter_project/src/viewModels/ProfileViewModel.dart';
import 'package:flutter_project/src/views/TokenView.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final tokenTextFieldController = TextEditingController();
  final _viewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(30.0)
        ),
        Row(
          children: <Widget>[
            Text("Name:"),
            Spacer(),
            FutureBuilder(
              future: _viewModel.getUserName(context),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                //print(snapshot);
                if(snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Text("No name");
                }
              }),
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(15.0)
        ),
        Row(
          children: <Widget>[
            Text("Email"),
            Spacer(),
            Text(_viewModel.getUserEmail(context))
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(30.0)
        ),
        RaisedButton(
          onPressed: () async {
            await context.read<AuthenticationService>().signOut();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text("Sign out"),
        ),
        Spacer(),
        FutureBuilder(
          future: context.read<AuthenticationService>().isUserAuthorizedUser(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            print(snapshot.data);
            if(snapshot.hasData) {
              if(snapshot.data) {
                return Spacer();
              } else{
                return RaisedButton(
                  onPressed: () {
                    openPage(context);
                  },
                  child: Text("Manage access to restricted content (generate token)."),
                );
              }
            } else {
              return RaisedButton(
                onPressed: () {
                  openPage(context);
                },
                child: Text("Manage access to restricted content (generate token)."),
              );
            }
          },
        )
      ],
    );
  }
}

void openPage(BuildContext context) {

  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: TokenView(),
        ),
      );
    },
  ));
}