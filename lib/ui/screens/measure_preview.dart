import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/measure_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class MeasurePreview extends StatelessWidget {
  final Measure measure;
  final bool isAdded;

  const MeasurePreview({@required this.measure, @required this.isAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.dark,
            title: Text("\"${measure.name}\" Measure")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ButtonBar(
                  children: [
                    if (!isAdded)
                      OutlineButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add to trial"),
                          onPressed: () {
                            _addMeasure(context);
                          }),
                  ],
                ),
                SizedBox(height: 50),
                SectionTitle("Preview"),
                Card(
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: MeasureWidget(measure: measure)),
                )
              ],
            ),
          ),
        ));
  }

  _addMeasure(context) {
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
                  title: "Measure",
                  objectWithSchedule: measure,
                  onSave: saveFunction),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Access denied. In order for StudyMe to track your ${measure.name} automatically you need to grant permissions.")));
      }
    });
  }
}
