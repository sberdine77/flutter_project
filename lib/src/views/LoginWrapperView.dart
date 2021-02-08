import 'LoginView.dart';
import 'SignUpView.dart';
import 'package:flutter/material.dart';

class LoginWrapperView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWrapperViewState();
  }
}

class _LoginWrapperViewState extends State<LoginWrapperView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    LoginView(),
    SignUpView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: navigationBarIconTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.login),
              label: 'Login'
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.arrow_upward),
              label: 'Sign Up'
          ),
        ],
      ),
    );
  }

  void navigationBarIconTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}