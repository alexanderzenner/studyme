import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';

class MeasureCard extends StatelessWidget {
  final Measure measure;
  final bool showSchedule;
  final void Function() onTap;

  MeasureCard({this.measure, this.onTap, this.showSchedule = false});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(measure.icon),
      title: Text(measure.name),
      subtitle: _getSubtitle(),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    ));
  }

  _getSubtitle() {
    if (showSchedule && measure.schedule != null) {
      return Text(measure.schedule.readable);
    } else {
      return null;
    }
  }
}
