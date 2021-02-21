import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';

class InterventionOverview extends StatelessWidget {
  final bool isA;
  final Intervention intervention;

  InterventionOverview({@required this.isA, @required this.intervention});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(isA ? "Intervention A" : "Intervention B"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (!isA)
                  ListTile(
                      title: Text("Type"), subtitle: Text(intervention.type)),
                if (intervention.schedule != null)
                  Column(
                    children: [
                      ListTile(
                          title: Text("Name"),
                          subtitle: Text(intervention.name)),
                      ListTile(
                          title: Text("Schedule"),
                          subtitle: Text(intervention.schedule.readable)),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
