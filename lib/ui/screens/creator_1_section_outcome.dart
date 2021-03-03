import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/goal_editor_outcome.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class CreatorGoalSection extends StatelessWidget {
  final AppData model;

  CreatorGoalSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle("Your goal"),
        if (!_outcomeIsSet())
          ButtonBar(
            children: [
              OutlineButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Select'),
                  onPressed: () => _navigateToGoalOutcomeEditor(context)),
            ],
          ),
        if (_outcomeIsSet())
          Card(
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.yellow),
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
