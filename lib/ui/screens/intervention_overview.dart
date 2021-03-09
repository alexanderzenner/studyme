import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/ui/screens/intervention_editor_instructions.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

import 'intervention_editor_name.dart';
import 'schedule_editor.dart';

class InterventionOverview extends StatefulWidget {
  final bool isA;

  const InterventionOverview({@required this.isA});

  @override
  _InterventionOverviewState createState() => _InterventionOverviewState();
}

class _InterventionOverviewState extends State<InterventionOverview> {
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
            Intervention intervention = widget.isA
                ? model.trial.interventionA
                : model.trial.interventionB;
            return Scaffold(
                appBar: AppBar(
                  brightness: Brightness.dark,
                  title: Text(intervention.name),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        EditableListTile(
                            title: Text("Name"),
                            subtitle: Text(intervention.name,
                                style: TextStyle(fontSize: 16)),
                            canEdit: true,
                            onTap: () => _editName(intervention)),
                        EditableListTile(
                            title: Text("Instructions"),
                            subtitle: Text(intervention.instructions,
                                style: TextStyle(fontSize: 16)),
                            canEdit: true,
                            onTap: () => _editInstructions(intervention)),
                        if (intervention.schedule != null)
                          ListTile(
                              title: Text("Schedule"),
                              subtitle: Text(intervention.schedule.readable,
                                  style: TextStyle(fontSize: 16)),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () => _editSchedule(intervention)),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                                icon: Icon(Icons.delete),
                                label: Text("Remove"),
                                onPressed: _remove),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          });
  }

  _editName(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionEditorName(
              isA: widget.isA,
              intervention: intervention.clone(),
              onSave: (Intervention _intervention) {
                _getSetter()(_intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editInstructions(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionEditorInstructions(
              intervention: intervention.clone(),
              onSave: (Intervention _intervention) {
                _getSetter()(_intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editSchedule(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: intervention.name,
              objectWithSchedule: intervention,
              onSave: (Intervention _intervention) {
                _getSetter()(_intervention);
                Navigator.pop(context);
              }),
        ));
  }

  _remove() {
    setState(() {
      _isDeleting = true;
    });
    _getSetter()(null);
    Navigator.pop(context);
  }

  _getSetter() {
    return widget.isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}
