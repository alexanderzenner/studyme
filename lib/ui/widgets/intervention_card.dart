import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/abstract_intervention.dart';

class InterventionCard extends StatelessWidget {
  final bool isA;
  final AbstractIntervention intervention;
  final void Function() onTap;

  InterventionCard({this.isA, this.intervention, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
            leading: Text(isA ? 'A' : 'B',
                style: TextStyle(
                    color: isA ? Colors.lightBlue : Colors.lightGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            title: Text(intervention.name),
            trailing: Icon(Icons.chevron_right),
            onTap: onTap));
  }
}
