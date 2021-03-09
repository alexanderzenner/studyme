import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/automatic_measure.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/choice_card.dart';
import 'package:studyme/util/string_extension.dart';
import 'package:studyme/util/util.dart';

import '../widgets/action_button.dart';

class MeasureEditorAutomaticType extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;

  const MeasureEditorAutomaticType(
      {@required this.measure, @required this.onSave});

  @override
  _MeasureEditorAutomaticTypeState createState() =>
      _MeasureEditorAutomaticTypeState();
}

class _MeasureEditorAutomaticTypeState
    extends State<MeasureEditorAutomaticType> {
  Measure _measure;

  @override
  initState() {
    print(widget.measure.name);
    _measure = widget.measure;
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
                    value: AutomaticMeasure.measureType,
                    selectedValue: _measure.type,
                    onSelect: _changeMeasureType,
                    title: Row(
                      children: [
                        Icon(AutomaticMeasure.icon),
                        SizedBox(width: 5),
                        Text(AutomaticMeasure.measureType.capitalize()),
                      ],
                    ),
                    body: [
                      Text(
                          "Requires using third party Google Fit or Apple Health app.",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      Text(
                          "Any measurement you add to the third party app during the trial is automatically fetched."),
                      Text(
                          "You will be asked to grant permission in the next step.")
                    ]),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _measure != null;
  }

  _submit() {
    _measure.canAdd.then((value) {
      if (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: _measure.name,
                  objectWithSchedule: _measure,
                  onSave: widget.onSave),
            ));
      } else {
        toast(context,
            "Permission denied. In order for StudyMe to track your ${_measure.name} automatically, you need to grant permissions.");
      }
    });
  }

  _changeMeasureType(String type) {
    if (type != _measure.type) {
      Measure _newMeasure;
      if (type == AutomaticMeasure.measureType) {
        _newMeasure = widget.measure;
      } else if (type == KeyboardMeasure.measureType) {
        _newMeasure = KeyboardMeasure(
            id: _measure.id, name: _measure.name, unit: _measure.unit);
      }
      setState(() {
        _measure = _newMeasure;
      });
    }
  }
}
