import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/outcome_library.dart';
import 'package:studyme/ui/widgets/outcome_card.dart';

import 'outcome_overview.dart';

class CreatorGoalSection extends StatelessWidget {
  final AppData model;

  CreatorGoalSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your goal',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColor)),
        if (!_outcomeIsSet())
          ButtonBar(
            children: [
              OutlinedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Select'),
                  onPressed: () => _addOutcome(context)),
            ],
          ),
        if (_outcomeIsSet())
          OutcomeCard(
              outcome: model.trial.outcome, onTap: () => _viewOutcome(context))
      ],
    );
  }

  bool _outcomeIsSet() {
    return model.trial.outcome != null;
  }

  _addOutcome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutcomeLibrary(),
      ),
    );
  }

  _viewOutcome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OutcomeOverview(isPreview: false, outcome: model.trial.outcome),
      ),
    );
  }
}
