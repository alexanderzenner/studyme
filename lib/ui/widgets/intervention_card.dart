import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';

class InterventionCard extends StatelessWidget {
  final Intervention intervention;
  final void Function() onTap;

  InterventionCard({this.intervention, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
            leading: InterventionLetter(intervention.letter),
            title: intervention != null ? Text(intervention.name) : null,
            subtitle: _getSubtitle(),
            trailing: onTap != null ? Icon(Icons.chevron_right) : null,
            onTap: onTap));
  }

  Widget _getSubtitle() {
    if (intervention.schedule != null) {
      return Text(intervention.schedule.readable);
    } else {
      return null;
    }
  }
}
