import 'package:flutter/material.dart';
import 'HomeContentView.dart';
import 'RestrictedContentView.dart';

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
    RestrictedContentView(Colors.deepOrange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter project')
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