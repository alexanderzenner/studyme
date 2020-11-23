import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';

class InterventionScreen extends StatelessWidget {
  final Intervention intervention;

  InterventionScreen(this.intervention);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(intervention.name)),
        body: Center(
            child: Column(children: [
          Text(intervention.description),
          OutlineButton(
            child: Text('Ok'),
            onPressed: () => print('completed'),
          ),
        ])));
  }
}
