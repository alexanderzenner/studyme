import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';

class KeyboardMeasureWidget extends StatelessWidget {
  final KeyboardMeasure measure;

  final void Function(num value) updateValue;

  KeyboardMeasureWidget(this.measure, this.updateValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          autofocus: this.updateValue != null ? true : false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: measure.unit),
          onChanged: (text) {
            num value;
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
