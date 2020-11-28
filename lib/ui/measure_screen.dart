import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/widgets/choice_measure_widget.dart';
import 'package:studyme/widgets/free_measure_widget.dart';
import 'package:studyme/widgets/scale_measure_widget.dart';

class MeasureScreen extends StatefulWidget {
  final Measure measure;

  MeasureScreen(this.measure);

  @override
  _MeasureScreenState createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  double _value;

  @override
  void initState() {
    _value = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.measure.name)),
        body: Center(
            child: Column(children: [
          _buildMeasureWidget(),
          OutlineButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context, _value);
            },
          ),
        ])));
  }

  _buildMeasureWidget() {
    switch (widget.measure.runtimeType) {
      case (FreeMeasure):
        return FreeMeasureWidget(widget.measure, (value) => _updateValue(value));
      case (ScaleMeasure):
        return ScaleMeasureWidget(widget.measure, (value) => _updateValue(value));
      case (ChoiceMeasure):
        return ChoiceMeasureWidget(widget.measure, (value) => _updateValue(value));
    }
  }

  _updateValue(value) {
    setState(() {
      _value = value;
    });
  }
}
