import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/default_interventions.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/intervention_overview.dart';
import 'package:studyme/ui/widgets/intervention_card_new.dart';

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
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                  isA
                      ? "What is one thing you want to try out to achieve your goal (${model.trial.outcome})?"
                      : 'What is the other thing you want to try out and compare to "${model.trial.a.name}"?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'Create your own',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {
                          _createIntervention(context);
                        }),
                    Text('or select existing:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: defaultInterventions.length,
                  itemBuilder: (context, index) {
                    Intervention _intervention = defaultInterventions[index];
                    return InterventionCardNew(
                        intervention: _intervention,
                        onTap: () =>
                            _previewIntervention(context, _intervention));
                  },
                ),
              )
            ],
          ),
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
