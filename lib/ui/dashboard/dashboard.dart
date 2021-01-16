import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/ui/dashboard/history.dart';
import 'package:studyme/ui/dashboard/profile.dart';

import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex;

  List<String> _titles = ['Home', 'History', 'Profile'];

  List<Function> _body = [() => Home(), () => History(), () => Profile()];

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _body[_currentIndex](),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: _titles[0],
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.insert_chart),
              label: _titles[1],
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: _titles[2])
          ]),
    );
  }
}
