import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';

class ChoiceMeasureWidget extends StatelessWidget {
  final ChoiceMeasure measure;

  ChoiceMeasureWidget(this.measure);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...measure.choices.asMap().entries.map((entry) =>
          Card(key: UniqueKey(), child: ListTile(title: Text('${entry.key + 1}. ${entry.value.value}'), onTap: () {})))
    ]);
  }
}
