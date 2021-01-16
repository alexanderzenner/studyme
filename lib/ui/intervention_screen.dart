import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';

class InterventionScreen extends StatelessWidget {
  final Intervention intervention;

  InterventionScreen(this.intervention);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(intervention.name),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )
          ],
        ),
        body: Center(
            child: Column(children: [
          Text(intervention.description),
        ])));
  }
}
