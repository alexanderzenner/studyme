import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/scale_measure.dart';

class ScaleMeasureWidget extends StatelessWidget {
  final ScaleMeasure measure;

  ScaleMeasureWidget(this.measure);

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: measure.min, min: measure.min, max: measure.max, divisions: (measure.max - measure.min).toInt());
  }
}
