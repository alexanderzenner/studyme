import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/util/util.dart';

import '../../routes.dart';
import 'history.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex;

  List<String> _titles = ['Home', 'History'];

  List<Function> _body = [() => Home(), () => History()];

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
        actions: [
          PopupMenuButton<Option>(
              onSelected: (Option option) {
                option.callback();
              },
              itemBuilder: (context) => [
                    Option(
                        name: 'Edit trial (Debug)',
                        callback: () {
                          Provider.of<AppState>(context, listen: false)
                              .saveIsEditing(true);
                          Navigator.pushReplacementNamed(
                              context, Routes.creator);
                        }),
                    Option(
                        name: 'Cancel trial',
                        callback: () {
                          Provider.of<AppState>(context, listen: false)
                              .createNewTrial();
                          Navigator.pushReplacementNamed(
                              context, Routes.creator);
                        })
                  ]
                      .map((option) => PopupMenuItem<Option>(
                          value: option, child: Text(option.name)))
                      .toList())
        ],
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
            )
          ]),
    );
  }
}
