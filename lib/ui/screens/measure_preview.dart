import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/util/string_extension.dart';
import 'package:studyme/util/util.dart';

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
                  if (_measure is SyncedMeasure)
                    HintCard(
                      titleText: "Synced measure",
                      body: [
                        Text(
                            "This measure requires using the third party Google Fit or Apple Health app. Any measurement you add to the third party app during the trial is automatically fetched.")
                      ],
                    ),
                  ListTile(
                    title: Text("Name"),
                    subtitle: Text(_measure.name),
                  ),
                  ListTile(
                    title: Text("Input Type"),
                    subtitle: Row(
                      children: [
                        Icon(_measure.getIcon()),
                        SizedBox(width: 5),
                        Text(_measure.type.capitalize()),
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
                    children: [
                      OutlinedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add to experiment"),
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

    measure.canAdd.then((value) {
      if (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: measure.name,
                  objectWithSchedule: measure,
                  onSave: saveFunction),
            ));
      } else {
        toast(context,
            "Access denied. In order for StudyMe to track your ${measure.name} automatically you need to grant permissions.");
      }
    });
  }
}
