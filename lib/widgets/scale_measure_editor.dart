import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/scale_measure.dart';

class ScaleMeasureEditor extends StatelessWidget {
  final ScaleMeasure measure;

  ScaleMeasureEditor(this.measure);

  @override
  Widget build(BuildContext context) {
    print('hi');
    return Container(
      child: Column(children: [
        TextFormField(
          keyboardType: TextInputType.number,
          initialValue: measure.min.toInt().toString(),
          onChanged: (text) {
            measure.min = double.parse(text);
          },
          decoration: InputDecoration(hintText: 'Min'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          initialValue: measure.max.toInt().toString(),
          onChanged: (text) {
            measure.max = double.parse(text);
          },
          decoration: InputDecoration(hintText: 'Max'),
        ),
      ]),
    );
  }
}
