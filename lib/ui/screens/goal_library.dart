import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/default_goals.dart';
import 'package:studyme/models/goal.dart';
import 'package:studyme/ui/screens/goal_editor.dart';
import 'package:studyme/ui/screens/goal_preview.dart';
import 'package:studyme/ui/widgets/library_create_button.dart';
import 'package:studyme/ui/widgets/goal_card.dart';

class GoalLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      List<Goal> goals = defaultGoals;
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text("What is a goal you have for your health or well-being?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              LibraryCreateButton(onPressed: () => _createGoal(context)),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    Goal _goal = goals[index];
                    return GoalCard(
                        goal: _goal, onTap: () => _previewGoal(context, _goal));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _previewGoal(context, Goal goal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalPreview(goal: goal),
      ),
    );
  }

  _createGoal(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GoalEditor(
                  goal: Goal(),
                  onSave: _getSaveFunction(context),
                )));
  }

  _getSaveFunction(context) {
    return (Goal goal) {
      Provider.of<AppData>(context, listen: false).setGoal(goal);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };
  }
}
