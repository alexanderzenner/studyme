import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

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
            return ChoiceCard<num>(
                value: index,
                selectedValue: _state,
                title: Text('${widget.measure.choices[index].value}'),
                onSelect: _updateValue);
          }),
    );
  }

  _updateValue(num value) {
    setState(() {
      _state = value;
    });
    if (widget.updateValue != null) {
      widget.updateValue(_state);
    }
  }
}
