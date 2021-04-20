import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/ui/screens/settings.dart';

import 'history.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex;

  List<String> _titles = ['Home', 'History', 'Settings'];

  List<Function> _body = [() => Home(), () => History(), () => Settings()];

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _body[_currentIndex]()),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              label: _titles[2],
            )
          ]),
    );
  }
}
