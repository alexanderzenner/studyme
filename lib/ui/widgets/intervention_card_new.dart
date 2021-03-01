import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';

class InterventionCardNew extends StatelessWidget {
  final Intervention intervention;
  final bool showSchedule;
  final void Function() onTap;

  InterventionCardNew(
      {this.intervention, this.onTap, this.showSchedule = false});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(intervention.name),
      subtitle: _getSubtitle(),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    ));
  }

  _getSubtitle() {
    if (showSchedule && intervention.schedule != null) {
      return Text(intervention.schedule.readable);
    } else {
      return null;
    }
  }
}
