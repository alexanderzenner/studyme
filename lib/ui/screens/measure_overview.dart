import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/ui/screens/measure_editor_scale.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';
import 'package:studyme/ui/widgets/measure_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/util/string_extension.dart';

import 'measure_editor_choice.dart';
import 'measure_editor_name.dart';
import 'schedule_editor.dart';

class MeasureOverview extends StatefulWidget {
  final bool isPreview;
  final Measure measure;
  final int index;
  const MeasureOverview({@required this.isPreview, this.measure, this.index});

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
    if (widget.measure != null) {
      return _buildMeasureOverview(widget.measure);
    } else {
      return _isDeleting
          ? Text('')
          : Consumer<AppData>(builder: (context, model, child) {
              Measure measure = model.trial.measures[widget.index];
              return _buildMeasureOverview(measure);
            });
    }
  }

  Widget _buildMeasureOverview(Measure measure) {
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
                  EditableListTile(
                      title: Text("Name"),
                      subtitle: Text(measure.name),
                      canEdit: _canEditName(measure),
                      onTap: () => _editName(context, measure)),
                  if (!widget.isPreview)
                    EditableListTile(
                        title: Text("Schedule"),
                        subtitle: Text(measure.schedule.readable),
                        onTap: () => _editSchedule(context, measure)),
                  if (measure is ChoiceMeasure)
                    EditableListTile(
                        title: Text("Choices"),
                        subtitle: Text(measure.choicesString),
                        canEdit: !widget.isPreview,
                        onTap: () => _editChoices(context, measure)),
                  if (measure is ScaleMeasure)
                    EditableListTile(
                        title: Text("Scale"),
                        subtitle: Text(measure.scaleString),
                        canEdit: !widget.isPreview,
                        onTap: () => _editScale(context, measure)),
                  ButtonBar(
                    children: [
                      if (widget.isPreview)
                        OutlineButton.icon(
                            icon: Icon(Icons.add),
                            label: Text("Add to trial"),
                            onPressed: () {
                              _addMeasure(context);
                            }),
                      if (!widget.isPreview)
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
  }

  _addMeasure(context) {
    Function saveFunction = (Measure measure) {
      Provider.of<AppData>(context, listen: false).addMeasure(measure);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    widget.measure.canAdd.then((value) {
      if (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: "Measure",
                  objectWithSchedule: widget.measure,
                  onSave: saveFunction),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Access denied. In order for StudyMe to track your ${widget.measure.name} automatically you need to grant permissions.")));
      }
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
    return !widget.isPreview && !(measure is SyncedMeasure);
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
