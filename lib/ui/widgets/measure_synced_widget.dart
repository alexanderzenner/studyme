import 'package:flutter/material.dart';
import 'package:studyme/models/measure/synced_measure.dart';

class SyncedMeasureWidget extends StatelessWidget {
  final SyncedMeasure measure;

  SyncedMeasureWidget({this.measure});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "This measure will be automatically fetched from your Google Fit / Apple Health app"),
      ],
    );
  }
}
