import 'package:flutter/material.dart';
import 'package:studyme/models/measure/synced_measure.dart';

class SyncedMeasureWidget extends StatelessWidget {
  final SyncedMeasure measure;

  final bool confirmed;

  final void Function(bool) setCanSave;

  SyncedMeasureWidget({this.measure, this.confirmed, this.setCanSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "This measure will be automatically fetched from your Google Fit / Apple Health app"),
        if (setCanSave != null)
          SwitchListTile(
            title: Text(
                "I logged my ${measure.name} weight in my Google Fit / Apple Health app"),
            value: confirmed,
            onChanged: setCanSave,
          )
      ],
    );
  }
}
