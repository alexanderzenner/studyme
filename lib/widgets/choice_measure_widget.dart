import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';

class ChoiceMeasureWidget extends StatefulWidget {
  final ChoiceMeasure measure;

  final void Function(double value) updateValue;

  ChoiceMeasureWidget(this.measure, this.updateValue);

  @override
  _ChoiceMeasureWidgetState createState() => _ChoiceMeasureWidgetState();
}

class _ChoiceMeasureWidgetState extends State<ChoiceMeasureWidget> {
  double _state;

  @override
  void initState() {
    _state = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...widget.measure.choices.asMap().entries.map((entry) => Card(
          key: UniqueKey(),
          child: Ink(
            color: _state == (entry.key).toDouble() ? Theme.of(context).primaryColor : Colors.transparent,
            child: ListTile(
                title: Text('${entry.value.value}'),
                onTap: () {
                  setState(() {
                    _state = (entry.key).toDouble();
                  });
                  if (widget.updateValue != null) {
                    widget.updateValue(_state);
                  }
                }),
          )))
    ]);
  }
}
