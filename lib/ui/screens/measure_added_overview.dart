import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/ui/screens/measure_editor_scale.dart';
import 'package:studyme/ui/widgets/measure_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/util/string_extension.dart';

import 'measure_editor_choice.dart';
import 'measure_editor_name.dart';
import 'schedule_editor.dart';

class MeasureOverview extends StatefulWidget {
  final int index;
  const MeasureOverview({@required this.index});

  @override
  _MeasureOverviewState createState() => _MeasureOverviewState();
}

class _MeasureOverviewState extends State<MeasureOverview> {
  bool _isDeleting;

  @override
  void initState() {
    _isDeleting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isDeleting
        ? Text('')
        : Consumer<AppData>(builder: (context, model, child) {
            Measure measure = model.trial.measures[widget.index];
            return Scaffold(
                appBar: AppBar(
                    brightness: Brightness.dark,
                    title: Text("\"${measure.name}\" Measure")),
                body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Type"),
                            subtitle: Text(measure.type.capitalize()),
                          ),
                          ListTile(
                              title: Text("Name"),
                              subtitle: Text(measure.name),
                              trailing: _canEditName(measure)
                                  ? Icon(Icons.chevron_right)
                                  : null,
                              onTap: _canEditName(measure)
                                  ? () => _editName(context, measure)
                                  : null),
                          ListTile(
                              title: Text("Schedule"),
                              subtitle: Text(measure.schedule.readable),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () => _editSchedule(context, measure)),
                          if (measure is ChoiceMeasure)
                            ListTile(
                                title: Text("Choices"),
                                subtitle: Text(measure.choicesString),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () => _editChoices(context, measure)),
                          if (measure is ScaleMeasure)
                            ListTile(
                                title: Text("Scale"),
                                subtitle: Text(measure.scaleString),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () => _editScale(context, measure)),
                          ButtonBar(
                            children: [
                              OutlineButton.icon(
                                  icon: Icon(Icons.delete),
                                  label: Text("Remove"),
                                  onPressed: () => _removeMeasure(context)),
                            ],
                          ),
                          SizedBox(height: 50),
                          SectionTitle("Preview"),
                          Card(
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    MeasureWidget(measure: measure),
                                  ],
                                )),
                          )
                        ],
                      )),
                ));
          });
  }

  _removeMeasure(BuildContext context) {
    setState(() {
      _isDeleting = true;
    });
    Provider.of<AppData>(context, listen: false).removeMeasure(widget.index);
    Navigator.pop(context);
  }

  _canEditName(Measure measure) {
    return !(measure is SyncedMeasure);
  }

  _editName(BuildContext context, Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorName(
              title: "Measure",
              measure: measure.clone(),
              onSave: _getSaveFunction(context),
              save: true),
        ));
  }

  _editSchedule(BuildContext context, Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
            title: "Measure",
            objectWithSchedule: measure,
            onSave: _getSaveFunction(context),
          ),
        ));
  }

  _editChoices(BuildContext context, ChoiceMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorChoice(
              title: "Measure",
              measure: measure.clone(),
              onSave: _getSaveFunction(context),
              save: true),
        ));
  }

  _editScale(BuildContext context, ScaleMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorScale(
              title: "Measure",
              measure: measure.clone(),
              onSave: _getSaveFunction(context),
              save: true),
        ));
  }

  _getSaveFunction(context) {
    return (Measure _measure) {
      Provider.of<AppData>(context).updateMeasure(widget.index, _measure);
      Navigator.pop(context);
    };
  }
}
