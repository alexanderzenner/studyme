import 'package:flutter/material.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

import 'measure_list_widget.dart';
import 'measure_keyboard_widget.dart';
import 'measure_scale_widget.dart';

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
      case KeyboardMeasure:
        return KeyboardMeasureWidget(measure, updateValue);
        break;
      case ListMeasure:
        return ListMeasureWidget(measure, updateValue);
      case ScaleMeasure:
        return ScaleMeasureWidget(measure, updateValue);
      default:
        return Text('HI');
    }
  }
}
