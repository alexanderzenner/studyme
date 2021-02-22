import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

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
    return Scaffold(
        appBar: AppBar(brightness: Brightness.dark, title: Text("Measure")),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _isDeleting
                  ? Text('')
                  : Consumer<AppData>(builder: (context, model, child) {
                      Measure measure = model.trial.measures[widget.index];
                      if (measure != null) {
                        return Column(
                          children: [
                            ListTile(
                                title: Text("Name"),
                                subtitle: Text(measure.name),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () => _editName(context, measure)),
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
                                  trailing: Icon(Icons.chevron_right)),
                            ButtonBar(
                              children: [
                                OutlineButton.icon(
                                    icon: Icon(Icons.delete),
                                    label: Text("Remove"),
                                    onPressed: () => _removeMeasure(context)),
                              ],
                            )
                          ],
                        );
                      } else {
                        return Column(
                          children: [],
                        );
                      }
                    })),
        ));
  }

  _removeMeasure(BuildContext context) {
    setState(() {
      _isDeleting = true;
    });
    Provider.of<AppData>(context, listen: false).removeMeasure(widget.index);
    Navigator.pop(context);
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

  _getSaveFunction(context) {
    return (Measure _measure) {
      Provider.of<AppData>(context).updateMeasure(widget.index, _measure);
      Navigator.pop(context);
    };
  }
}
