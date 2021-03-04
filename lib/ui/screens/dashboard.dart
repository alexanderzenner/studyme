import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/settings.dart';
import 'dart:convert';

import 'package:studyme/util/util.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.share),
        label: Text(
          'Copy Settings For Survey',
        ),
        onPressed: () => _exportTrialInfo(context),
      ),
    );
  }

  _exportTrialInfo(BuildContext context) {
    Clipboard.setData(new ClipboardData(
        text: json.encode(
            Provider.of<AppData>(context, listen: false).trial.toJson())));
    toast(context,
        "Settings copied to clipboard. Please paste them into the corresponding survey field.");
  }
}
