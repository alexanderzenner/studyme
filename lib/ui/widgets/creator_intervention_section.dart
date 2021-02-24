import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import '../screens/intervention_editor_name.dart';
import '../screens/intervention_overview.dart';
import 'hint_card.dart';
import 'intervention_card.dart';
import 'section_title.dart';

class CreatorInterventionSection extends StatelessWidget {
  final AppData model;
  final bool isActive;

  CreatorInterventionSection(this.model, {this.isActive});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isActive && model.trial.a == null && model.trial.b == null)
            HintCard(titleText: "Add Intervention A", body: [
              Text(
                  "Let's start setting up your trial. First you need to decide what interventions you want to compare."),
              Text(''),
              Text(
                  'Click on the \"+\" icon next to \"Interventions\", to set Intervention A')
            ]),
          if (isActive && model.trial.b == null && model.trial.a != null)
            HintCard(
              titleText: "Add Intervention B",
              body: [
                Text(
                    "Great! Next you need to decide what you will compare \"Intervention A\" to."),
                Text(''),
                Text(
                    "Click on the \"+\" icon next to \"Interventions\", to set \"Intervention B\"."),
              ],
            ),
          SectionTitle(
            'Interventions',
          ),
          if (isActive)
            InterventionCard(
                letter: 'a',
                intervention: model.trial.a,
                showSchedule: true,
                onTap: () {
                  model.trial.a == null
                      ? _addIntervention(context, true)
                      : _viewIntervention(context, true);
                }),
          if (isActive)
            InterventionCard(
                letter: 'b',
                showSchedule: true,
                intervention: model.trial.b,
                onTap: () {
                  model.trial.b == null
                      ? _addIntervention(context, false)
                      : _viewIntervention(context, false);
                }),
        ],
      ),
    );
  }

  _viewIntervention(context, isA) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionOverview(isA: isA),
      ),
    );
  }

  _addIntervention(context, isA) {
    Function setter = isA ? model.setInterventionA : model.setInterventionB;
    Function saveFunction = (Intervention intervention) {
      setter(intervention);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionEditorName(
            title: isA ? "Intervention A" : "Intervention B",
            intervention: Intervention(),
            onSave: saveFunction,
            save: false),
      ),
    );
  }
}
