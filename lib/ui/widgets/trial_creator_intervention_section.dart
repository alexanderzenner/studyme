import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';

import '../screens/intervention_editor.dart';

class TrialCreatorInterventionSection extends StatelessWidget {
  final AppState model;

  TrialCreatorInterventionSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Interventions', style: TextStyle(fontWeight: FontWeight.bold)),
        InterventionCard(
            isA: true,
            intervention: model.trial.a,
            onTap: () {
              _editInterventionA(context, model);
            }),
        InterventionCard(
            isA: false,
            intervention: model.trial.b,
            onTap: () {
              _editInterventionB(context, model);
            }),
      ],
    );
  }

  _editInterventionA(context, model) {
    _navigateToInterventionEditor(context, true, model.trial.a).then((result) {
      if (result != null) {
        model.setInterventionA(result);
      }
    });
  }

  _editInterventionB(context, model) {
    _navigateToInterventionEditor(context, false, model.trial.b).then((result) {
      if (result != null) {
        model.setInterventionB(result);
      }
    });
  }

  Future _navigateToInterventionEditor(context, isA, intervention) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InterventionEditor(isA: isA, intervention: intervention),
      ),
    );
  }
}
