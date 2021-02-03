import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/free_measure.dart';

class FreeMeasureWidget extends StatelessWidget {
  final FreeMeasure measure;

  final void Function(num value) updateValue;

  FreeMeasureWidget(this.measure, this.updateValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (text) {
            int value;
            if (updateValue != null) {
              try {
                value = text.length > 0 ? num.parse(text) : null;
              } on Exception catch (_) {
                value = null;
              }

              updateValue(value);
            }
          }),
    );
  }
}
