import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

import '../widgets/action_button.dart';
import 'measure_editor_name.dart';

class MeasureCreatorType extends StatefulWidget {
  final Function(Measure measure) onSave;

  const MeasureCreatorType({@required this.onSave});

  @override
  _MeasureCreatorTypeState createState() => _MeasureCreatorTypeState();
}

class _MeasureCreatorTypeState extends State<MeasureCreatorType> {
  Measure _measure;

  @override
  initState() {
    _measure = FreeMeasure();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Measure"),
              Visibility(
                visible: true,
                child: Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
              icon: Icons.arrow_forward,
              canPress: _canSubmit(),
              onPressed: _submit,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  autofocus: true,
                  value: _measure.type,
                  onChanged: _changeMeasureType,
                  items: [
                    FreeMeasure.measureType,
                    ChoiceMeasure.measureType,
                    ScaleMeasure.measureType
                  ].map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          '${value[0].toUpperCase()}${value.substring(1)}'),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Type'),
                )
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _measure != null;
  }

  _submit() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorName(
              title: "Measure",
              measure: _measure,
              onSave: widget.onSave,
              save: false),
        ));
  }

  _changeMeasureType(String type) {
    if (type != _measure.type) {
      Measure _newMeasure;
      if (type == FreeMeasure.measureType) {
        _newMeasure = FreeMeasure();
      } else if (type == ChoiceMeasure.measureType) {
        _newMeasure = ChoiceMeasure();
      } else if (type == ScaleMeasure.measureType) {
        _newMeasure = ScaleMeasure();
      }
      _newMeasure.description = _measure.description;
      setState(() {
        _measure = _newMeasure;
      });
    }
  }
}
