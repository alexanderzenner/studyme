import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/measure_editor_scale.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';
import 'package:studyme/util/string_extension.dart';

import 'measure_editor_list.dart';
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
                    brightness: Brightness.dark, title: Text(measure.name)),
                body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          EditableListTile(
                              title: Text("Name"),
                              subtitle: Text(measure.name),
                              canEdit: measure.canEdit,
                              onTap: () => _editName(measure)),
                          ListTile(
                            title: Text("Input Type"),
                            subtitle: Row(
                              children: [
                                Icon(measure.getIcon()),
                                SizedBox(width: 5),
                                Text(measure.type.capitalize()),
                              ],
                            ),
                          ),
                          if (measure is ListMeasure)
                            EditableListTile(
                                title: Text("List Items"),
                                subtitle: Text(measure.itemsString),
                                onTap: () => _editItems(measure)),
                          if (measure is ScaleMeasure)
                            EditableListTile(
                                title: Text("Scale"),
                                subtitle: Text(measure.scaleString),
                                onTap: () => _editScale(measure)),
                          EditableListTile(
                              title: Text("Schedule"),
                              subtitle: Text(measure.schedule.readable),
                              onTap: () => _editSchedule(measure)),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                  icon: Icon(Icons.delete),
                                  label: Text("Remove"),
                                  onPressed: _removeMeasure),
                            ],
                          ),
                        ],
                      )),
                ));
          });
  }

  _removeMeasure() {
    setState(() {
      _isDeleting = true;
    });
    Provider.of<AppData>(context, listen: false).removeMeasure(widget.index);
    Navigator.pop(context);
  }

  _editName(Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorName(
              measure: measure.clone(), onSave: _getSaveFunction(), save: true),
        ));
  }

  _editSchedule(Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
            title: measure.name,
            objectWithSchedule: measure,
            onSave: _getSaveFunction(),
          ),
        ));
  }

  _editItems(ListMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorList(
              measure: measure.clone(), onSave: _getSaveFunction(), save: true),
        ));
  }

  _editScale(ScaleMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorScale(
              measure: measure.clone(), onSave: _getSaveFunction(), save: true),
        ));
  }

  _getSaveFunction() {
    return (Measure _measure) {
      Provider.of<AppData>(context, listen: false)
          .updateMeasure(widget.index, _measure);
      Navigator.pop(context);
    };
  }
}
