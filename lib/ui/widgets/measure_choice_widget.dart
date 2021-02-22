import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';

class ChoiceMeasureWidget extends StatefulWidget {
  final ChoiceMeasure measure;

  final void Function(num value) updateValue;

  ChoiceMeasureWidget(this.measure, this.updateValue);

  @override
  _ChoiceMeasureWidgetState createState() => _ChoiceMeasureWidgetState();
}

class _ChoiceMeasureWidgetState extends State<ChoiceMeasureWidget> {
  num _state;

  @override
  void initState() {
    _state = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.measure.choices.length,
          itemBuilder: (context, index) {
            return Card(
                key: UniqueKey(),
                child: Ink(
                  color: _state == index
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  child: ListTile(
                      title: Text('${widget.measure.choices[index].value}'),
                      onTap: () {
                        setState(() {
                          _state = index;
                        });
                        if (widget.updateValue != null) {
                          widget.updateValue(_state);
                        }
                      }),
                ));
          }),
    );
  }
}
