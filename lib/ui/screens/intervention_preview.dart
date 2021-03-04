import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';

class InterventionPreview extends StatelessWidget {
  final bool isA;
  final Intervention intervention;

  InterventionPreview({@required this.intervention, @required this.isA});

  @override
  Widget build(BuildContext context) {
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
                ListTile(
                  title: Text("Name"),
                  subtitle: Text(intervention.name),
                ),
                ButtonBar(
                  children: [
                    OutlinedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text("Add to trial"),
                        onPressed: () {
                          _addIntervention(context);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addIntervention(BuildContext context) {
    Function saveFunction = (Intervention intervention) {
      _getSetter(context)(intervention);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: intervention.name,
              objectWithSchedule: intervention,
              onSave: saveFunction),
        ));
  }

  _getSetter(BuildContext context) {
    return isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}
