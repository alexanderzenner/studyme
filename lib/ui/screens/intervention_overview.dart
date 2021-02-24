import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';

import 'intervention_editor_name.dart';
import 'schedule_editor.dart';

class InterventionOverview extends StatelessWidget {
  final bool isA;

  InterventionOverview({@required this.isA});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(_getTitle()),
        ),
        body: Consumer<AppData>(
          builder: (context, model, child) {
            Intervention intervention = isA ? model.trial.a : model.trial.b;
            if (intervention != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text("Name"),
                          subtitle: Text(intervention.name),
                          trailing: _canEditName(intervention)
                              ? Icon(Icons.chevron_right)
                              : null,
                          onTap: _canEditName(intervention)
                              ? () => _editName(context, intervention)
                              : null),
                      if (intervention.schedule != null)
                        ListTile(
                            title: Text("Schedule"),
                            subtitle: Text(intervention.schedule.readable),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => _editSchedule(context, intervention)),
                      if (_canRemove(intervention))
                        ButtonBar(
                          children: [
                            OutlineButton.icon(
                                icon: Icon(Icons.delete),
                                label: Text("Remove"),
                                onPressed: () => _remove(context)),
                          ],
                        )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [],
              );
            }
          },
        ));
  }

  bool _canRemove(intervention) {
    return !(intervention is NoIntervention);
  }

  bool _canEditName(intervention) {
    return !(intervention is NoIntervention);
  }

  _editName(context, intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionEditorName(
              title: _getTitle(),
              intervention: intervention,
              onSave: (Intervention _intervention) {
                _getSetter(context)(_intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editSchedule(context, intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: _getTitle(),
              objectWithSchedule: intervention,
              onSave: (Intervention _intervention) {
                _getSetter(context)(_intervention);
                Navigator.pop(context);
              }),
        ));
  }

  _remove(context) {
    _getSetter(context)(null);
    Navigator.pop(context);
  }

  _getSetter(context) {
    return isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }

  _getTitle() {
    return isA ? "Intervention A" : "Intervention B";
  }
}
