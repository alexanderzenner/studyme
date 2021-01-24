import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/free_measure.dart';

class FreeMeasureWidget extends StatelessWidget {
  final FreeMeasure measure;

  final void Function(double value) updateValue;

  FreeMeasureWidget(this.measure, this.updateValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) {
            if (updateValue != null) {
              updateValue(double.parse(value));
            }
          }),
    );
  }
}
