import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/goal_editor_outcome.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

import 'section_title.dart';

class CreatorGoalSection extends StatelessWidget {
  final AppData model;

  CreatorGoalSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_outcomeIsSet())
          HintCard(
            titleText: "Set Goal",
            body: [
              Text(
                  "Let's start setting up your trial. First you need to set a goal you want to achieve."),
              Text(''),
              Text("Click on the + below to set your goal.")
            ],
          ),
        SectionTitle('Goal',
            action: !_outcomeIsSet()
                ? IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _navigateToGoalOutcomeEditor(context),
                  )
                : null),
        if (_outcomeIsSet())
          Card(
            child: ListTile(
              leading: Icon(Icons.star_border),
              title: Text(model.trial.outcome),
              trailing: Icon(Icons.chevron_right),
              onTap: () => _navigateToGoalOutcomeEditor(context),
            ),
          ),
      ],
    );
  }

  bool _outcomeIsSet() {
    return model.trial.outcome != null;
  }

  _navigateToGoalOutcomeEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalEditorOutcome(
            outcome: model.trial.outcome,
            onSave: (String _outcome) {
              model.setOutcome(_outcome);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/creator', (r) => false);
            }),
      ),
    );
  }
}