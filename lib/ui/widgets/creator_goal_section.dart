import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/goal_editor.dart';
import 'package:studyme/util/text_blocks.dart';

import 'section_title.dart';

class CreatorGoalSection extends StatelessWidget {
  final AppData model;

  CreatorGoalSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Goal',
            action: IconButton(
              icon: Icon(model.trial.numberOfInterventions != null
                  ? Icons.edit
                  : Icons.add),
              onPressed: () => _navigateToGoalEditor(context),
            )),
        if (model.trial.numberOfInterventions != null)
          Card(
            child: ListTile(
                leading: Icon(Icons.star_border),
                title: Text("I want to lose weight"),
                subtitle: Row(
                  children: [
                    Text("and"),
                    ...(model.trial.numberOfInterventions == 1
                        ? evaluateOne
                        : compareTwo)
                  ],
                )),
          ),
      ],
    );
  }

  _navigateToGoalEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalEditor(
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
