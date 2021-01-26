import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';

class MeasureCard extends StatelessWidget {
  final Measure measure;

  final void Function() onTap;

  MeasureCard({this.measure, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
          leading: Icon(measure.icon),
          title: Text(measure.name),
          trailing: Icon(Icons.chevron_right),
          onTap: onTap,
        ));
  }
}
