import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/screens/intervention_creator_name.dart';
import 'package:studyme/ui/screens/intervention_creator_schedule.dart';

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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (!isA)
                      ListTile(
                          title: Text("Type"),
                          subtitle: Text(intervention.type)),
                    if (intervention.schedule != null)
                      Column(
                        children: [
                          ListTile(
                              title: Text("Name"),
                              subtitle: Text(intervention.name),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () => _editName(context, intervention)),
                          ListTile(
                              title: Text("Schedule"),
                              subtitle: Text(intervention.schedule.readable),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () =>
                                  _editSchedule(context, intervention)),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  _editName(context, intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionCreatorName(
              title: _getTitle(),
              intervention: intervention,
              onSave: (Intervention _intervention) {
                Provider.of<AppData>(context).setInterventionA(_intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editSchedule(context, intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionCreatorSchedule(
              title: _getTitle(),
              scheduledItem: intervention,
              onSave: (Intervention _intervention) {
                Provider.of<AppData>(context).setInterventionA(_intervention);
                Navigator.pop(context);
              }),
        ));
  }

  _getTitle() {
    return isA ? "Intervention A" : "Intervention B";
  }
}
