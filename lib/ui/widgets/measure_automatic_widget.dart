import 'package:flutter/material.dart';
import 'package:studyme/models/measure/automatic_measure.dart';

class AutomaticMeasureWidget extends StatelessWidget {
  final AutomaticMeasure measure;

  final bool confirmed;

  final void Function(bool) setConfirmed;

  AutomaticMeasureWidget({this.measure, this.confirmed, this.setConfirmed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (setConfirmed != null)
          SwitchListTile(
            title:
                Text("I entered the data in my Google Fit / Apple Health app"),
            value: confirmed,
            onChanged: setConfirmed,
          )
      ],
    );
  }
}
