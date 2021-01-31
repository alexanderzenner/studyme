import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/section_title.dart';

import '../screens/intervention_editor.dart';

class CreatorInterventionSection extends StatelessWidget {
  final AppState model;

  CreatorInterventionSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          'Interventions',
          action: _buildNextAction(context),
        ),
        if (model.trial.a != null)
          InterventionCard(
              isA: true,
              intervention: model.trial.a,
              onTap: () {
                _editIntervention(
                    context, true, model.trial.a, model.setInterventionA);
              }),
        if (model.trial.b != null)
          InterventionCard(
              isA: false,
              intervention: model.trial.b,
              onTap: () {
                _editIntervention(
                    context, false, model.trial.b, model.setInterventionB);
              }),
      ],
    );
  }

  _addIntervention(context, isA, newIntervention, setIntervention) {
    _navigateToInterventionEditor(context, isA, newIntervention).then((result) {
      if (result != null) {
        setIntervention(result);
      }
    });
  }

  _editIntervention(context, isA, intervention, setIntervention) {
    _navigateToInterventionEditor(context, isA, intervention).then((result) {
      if (result != null) {
        setIntervention(result);
      }
    });
  }

  Widget _buildNextAction(context) {
    if (model.trial.a == null) {
      return IconButton(
        icon: Icon(
          Icons.add,
        ),
        onPressed: () {
          _addIntervention(
              context, true, Intervention(), model.setInterventionA);
        },
      );
    } else if (model.trial.b == null) {
      return IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          _addIntervention(
              context, false, NoIntervention(), model.setInterventionB);
        },
      );
    } else {
      return null;
    }
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
