import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/default_interventions.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/intervention_overview.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

import 'intervention_editor_name.dart';

class InterventionLibrary extends StatelessWidget {
  final bool isA;

  InterventionLibrary({@required this.isA});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      List<Measure> _unaddedMeasures = model.unaddedMeasures;
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Add Intervention"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HintCard(
                titleText: "Add existing or new intervention",
                body: [
                  Text(
                      "You can choose from a set of predefined interventions or create your own."),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: defaultInterventions.length,
                itemBuilder: (context, index) {
                  Intervention _intervention = defaultInterventions[index];
                  return Card(
                      child: ListTile(
                          title: Text(_intervention.name),
                          onTap: () =>
                              _previewIntervention(context, _intervention)));
                },
              ),
              SizedBox(height: 90)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _createIntervention(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  _previewIntervention(context, Intervention intervention) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionOverview(
            isPreview: true, isA: isA, intervention: intervention),
      ),
    );
  }

  _createIntervention(BuildContext context) {
    Function saveFunction = (Intervention intervention) {
      _getSetter(context)(intervention);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionEditorName(
            intervention: Intervention(), onSave: saveFunction, save: false),
      ),
    );
  }

  _getSetter(BuildContext context) {
    return isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}
