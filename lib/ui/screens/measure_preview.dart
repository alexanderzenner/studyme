import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/automatic_measure.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/util/string_extension.dart';

import 'measure_editor_automatic_type.dart';

class MeasurePreview extends StatelessWidget {
  final Measure measure;

  MeasurePreview({@required this.measure});

  @override
  Widget build(BuildContext context) {
    Measure _measure = measure;
    return Scaffold(
        appBar: AppBar(brightness: Brightness.dark, title: Text(_measure.name)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Name"),
                    subtitle: Text(_measure.name),
                  ),
                  ListTile(
                    title: Text("Input Type"),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(_measure.getIcon()),
                            SizedBox(width: 5),
                            Text(_measure.type.capitalize()),
                            if (_measure is AutomaticMeasure) ...[
                              SizedBox(width: 5),
                              Text('/'),
                              SizedBox(width: 5),
                              Icon(KeyboardMeasure.icon),
                              SizedBox(width: 5),
                              Text(KeyboardMeasure.measureType.capitalize())
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (_measure is ListMeasure)
                    ListTile(
                      title: Text("List Items"),
                      subtitle: Text(_measure.choicesString),
                    ),
                  if (_measure is ScaleMeasure)
                    ListTile(
                      title: Text("Scale"),
                      subtitle: Text(_measure.scaleString),
                    ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add to Experiment"),
                          onPressed: () => _addMeasure(context)),
                    ],
                  ),
                ],
              )),
        ));
  }

  _addMeasure(BuildContext context) {
    Function saveFunction = (Measure measure) {
      Provider.of<AppData>(context, listen: false).addMeasure(measure);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    if (measure is AutomaticMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorAutomaticType(
                measure: measure, onSave: saveFunction),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleEditor(
                title: measure.name,
                objectWithSchedule: measure,
                onSave: saveFunction),
          ));
    }
  }
}
