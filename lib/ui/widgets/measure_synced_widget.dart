import 'package:flutter/material.dart';
import 'package:studyme/models/measure/synced_measure.dart';

class SyncedMeasureWidget extends StatelessWidget {
  final SyncedMeasure measure;

  final bool confirmed;

  final void Function(bool) setConfirmed;

  SyncedMeasureWidget({this.measure, this.confirmed, this.setConfirmed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (setConfirmed != null)
          SwitchListTile(
            title: Text(
                "I logged my ${measure.name} in my Google Fit / Apple Health app"),
            value: confirmed,
            onChanged: setConfirmed,
          )
      ],
    );
  }
}
