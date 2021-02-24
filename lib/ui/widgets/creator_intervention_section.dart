import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/ui/screens/intervention_editor_number_of.dart';
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
          if (isActive && model.trial.numberOfInterventions == null)
            HintCard(titleText: "Set Interventions", body: [
              Text(
                  'Click on the + below, to choose the number of interventions.')
            ]),
          SectionTitle('Interventions',
              action: model.trial.numberOfInterventions == null
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: isActive
                          ? () => _navigateToGoalNumberOfInterventionsEditor(
                              context)
                          : null,
                    )
                  : null),
          if (isActive && model.trial.numberOfInterventions != null)
            ..._buildBody(context)
        ],
      ),
    );
  }

  List<Widget> _buildBody(context) {
    return [
      Card(
        child: ListTile(
          leading: Icon(Icons.compare_arrows),
          title: model.trial.numberOfInterventions == 1
              ? Text('Evaluate one intervention')
              : Text('Compare two interventions'),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _navigateToGoalNumberOfInterventionsEditor(context),
        ),
      ),
      if ((model.trial.a == null || model.trial.b == null) &&
          model.trial.numberOfInterventions == 2)
        HintCard(titleText: "Add Intervention A & B", body: [
          Text(
              'Click on the cards below, to set the two interventions you want to compare.')
        ]),
      if (model.trial.a == null && model.trial.numberOfInterventions == 1)
        HintCard(titleText: "Add Intervention A", body: [
          Text(
              'Click on the card below, to set the intervention you want to evaluate.'),
          Text(''),
          Text(
              'Note: As you selected to evaluate one intervention, Intervention B was set to No Intervention automatically.')
        ]),
      InterventionCard(
          letter: 'a',
          intervention: model.trial.a,
          showSchedule: true,
          onTap: () {
            model.trial.a == null
                ? _addIntervention(context, true)
                : _viewIntervention(context, true);
          }),
      InterventionCard(
          letter: 'b',
          showSchedule: true,
          intervention: model.trial.b,
          onTap: !(model.trial.b is NoIntervention)
              ? () {
                  model.trial.b == null
                      ? _addIntervention(context, false)
                      : _viewIntervention(context, false);
                }
              : null),
    ];
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

  _navigateToGoalNumberOfInterventionsEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionEditorNumberOf(
            numberOfInterventions: model.trial.numberOfInterventions,
            onSave: (int number) {
              model.setNumberOfInterventions(number);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/creator', (r) => false);
            }),
      ),
    );
  }
}
