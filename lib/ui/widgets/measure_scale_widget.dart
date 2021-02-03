import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/scale_measure.dart';

class ScaleMeasureWidget extends StatefulWidget {
  final ScaleMeasure measure;

  final void Function(num value) updateValue;

  ScaleMeasureWidget(this.measure, this.updateValue);

  @override
  _ScaleMeasureWidgetState createState() => _ScaleMeasureWidgetState();
}

class _ScaleMeasureWidgetState extends State<ScaleMeasureWidget> {
  num _state;

  @override
  void initState() {
    _state = widget.measure.min;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            onChanged: (x) => setState(() {
                  _state = x;
                  if (widget.updateValue != null) {
                    widget.updateValue(x);
                  }
                }),
            value: _state,
            min: widget.measure.min,
            max: widget.measure.max,
            divisions: (widget.measure.max - widget.measure.min).toInt()),
      ],
    );
  }
}
