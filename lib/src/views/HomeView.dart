import 'package:flutter/material.dart';
import 'package:flutter_project/src/views/ProfileView.dart';
import 'HomeContentView.dart';
import 'RestrictedContentView.dart';
import '../services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeContentView(),
    RestrictedContentView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter project'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              openPage(context);
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: navigationBarIconTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.cancel_outlined),
              label: 'Restricted'
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


void openPage(BuildContext context) {

  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: ProfileView(),
        ),
      );
    },
  ));
}