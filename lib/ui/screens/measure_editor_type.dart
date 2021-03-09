import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/measure_editor_unit.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

import '../widgets/action_button.dart';
import 'measure_editor_list.dart';
import 'measure_editor_scale.dart';

class MeasureEditorType extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;

  const MeasureEditorType({@required this.measure, @required this.onSave});

  @override
  _MeasureEditorTypeState createState() => _MeasureEditorTypeState();
}

class _MeasureEditorTypeState extends State<MeasureEditorType> {
  Measure _measure;

  @override
  initState() {
    _measure = widget.measure.clone();
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
              Text(_measure.name),
              Visibility(
                visible: true,
                child: Text(
                  'Input Type',
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
                Text(
                    'How would you like to enter the values for "${_measure.name}"?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                SizedBox(height: 10),
                ChoiceCard<String>(
                    value: KeyboardMeasure.measureType,
                    selectedValue: _measure.type,
                    onSelect: _changeMeasureType,
                    title: Row(
                      children: [
                        Icon(KeyboardMeasure.icon),
                        SizedBox(width: 5),
                        Text("Keyboard"),
                      ],
                    ),
                    body: [
                      Text("Values are entered freely via the keyboard.")
                    ]),
                ChoiceCard<String>(
                    value: ListMeasure.measureType,
                    selectedValue: _measure.type,
                    onSelect: _changeMeasureType,
                    title: Row(
                      children: [
                        Icon(ListMeasure.icon),
                        SizedBox(width: 5),
                        Text("List"),
                      ],
                    ),
                    body: [
                      Text(
                          "Values are selected from a list of items that you create in the next step.")
                    ]),
                ChoiceCard<String>(
                  value: ScaleMeasure.measureType,
                  selectedValue: _measure.type,
                  onSelect: _changeMeasureType,
                  title: Row(
                    children: [
                      Icon(ScaleMeasure.icon),
                      SizedBox(width: 5),
                      Text("Scale"),
                    ],
                  ),
                  body: [
                    Text(
                        "Values are selected from a scale that you define in the next step.")
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _measure != null;
  }

  _submit() {
    if (_measure is ListMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorList(
                measure: _measure, onSave: widget.onSave, save: false),
          ));
    } else if (_measure is ScaleMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorScale(
                measure: _measure, onSave: widget.onSave, save: false),
          ));
    } else if (_measure is KeyboardMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorUnit(
                measure: widget.measure, onSave: widget.onSave, save: false),
          ));
    }
  }

  _changeMeasureType(String type) {
    if (type != _measure.type) {
      Measure _newMeasure;
      if (type == KeyboardMeasure.measureType) {
        _newMeasure = KeyboardMeasure();
      } else if (type == ListMeasure.measureType) {
        _newMeasure = ListMeasure();
      } else if (type == ScaleMeasure.measureType) {
        _newMeasure = ScaleMeasure();
      }
      _newMeasure.name = _measure.name;
      setState(() {
        _measure = _newMeasure;
      });
    }
  }
}
