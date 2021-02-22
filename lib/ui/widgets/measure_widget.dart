import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';

import 'measure_choice_widget.dart';
import 'measure_free_widget.dart';
import 'measure_scale_widget.dart';
import 'measure_synced_widget.dart';

class MeasureWidget extends StatelessWidget {
  final Measure measure;

  final void Function(num value) updateValue;

  final bool confirmed;

  final void Function(bool confirmed) setConfirmed;

  MeasureWidget(
      {this.measure, this.updateValue, this.confirmed, this.setConfirmed});

  @override
  Widget build(BuildContext context) {
    switch (measure.runtimeType) {
      case FreeMeasure:
        return FreeMeasureWidget(measure, updateValue);
        break;
      case ChoiceMeasure:
        return ChoiceMeasureWidget(measure, updateValue);
      case ScaleMeasure:
        return ScaleMeasureWidget(measure, updateValue);
      case SyncedMeasure:
        return SyncedMeasureWidget(
            measure: measure, confirmed: confirmed, setConfirmed: setConfirmed);
      default:
        return Text('HI');
    }
  }
}
