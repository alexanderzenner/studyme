import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/widgets/choice_card.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/util/string_extension.dart';

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
              Text("New Measure"),
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
                HintCard(
                  titleText: "Choose input type",
                  body: [
                    Text('Free', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('The measurement is entered via keyboard'),
                    Text(''),
                    Text('Choice',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        'The measurement is selected from a choice list. You need to define the choices in a next step.'),
                    Text(''),
                    Text('Scale',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        'The measurment is entered via a scale. You need to define the scale in a next step.'),
                    Text('')
                  ],
                ),
                SizedBox(height: 10),
                ChoiceCard<String>(
                    value: FreeMeasure.measureType,
                    selectedValue: _measure.type,
                    onSelect: _changeMeasureType,
                    title: Row(
                      children: [
                        Icon(FreeMeasure.icon),
                        SizedBox(width: 5),
                        Text(FreeMeasure.measureType.capitalize()),
                      ],
                    )),
                ChoiceCard<String>(
                    value: ChoiceMeasure.measureType,
                    selectedValue: _measure.type,
                    onSelect: _changeMeasureType,
                    title: Row(
                      children: [
                        Icon(ChoiceMeasure.icon),
                        SizedBox(width: 5),
                        Text(ChoiceMeasure.measureType.capitalize()),
                      ],
                    )),
                ChoiceCard<String>(
                    value: ScaleMeasure.measureType,
                    selectedValue: _measure.type,
                    onSelect: _changeMeasureType,
                    title: Row(
                      children: [
                        Icon(ScaleMeasure.icon),
                        SizedBox(width: 5),
                        Text(ScaleMeasure.measureType.capitalize()),
                      ],
                    )),
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
              measure: _measure, onSave: widget.onSave, save: false),
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
