import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/goal.dart';
import 'package:studyme/ui/screens/goal_editor.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

class GoalOverview extends StatefulWidget {
  const GoalOverview();

  @override
  _GoalOverviewState createState() => _GoalOverviewState();
}

class _GoalOverviewState extends State<GoalOverview> {
  bool _isDeleting;

  @override
  void initState() {
    _isDeleting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isDeleting
        ? Text('')
        : Consumer<AppData>(builder: (context, model, child) {
            Goal goal = model.trial.goal;
            return Scaffold(
                appBar: AppBar(
                  brightness: Brightness.dark,
                  title: Text(goal.goal),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        EditableListTile(
                            title: Text("Goal"),
                            subtitle:
                                Text(goal.goal, style: TextStyle(fontSize: 16)),
                            onTap: () => _editGoal(goal)),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                                icon: Icon(Icons.delete),
                                label: Text("Remove"),
                                onPressed: _remove),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          });
  }

  _editGoal(Goal goal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalEditor(
            goal: goal,
            onSave: (Goal _goal) {
              _getSetter()(_goal);
              Navigator.pop(context);
            }),
      ),
    );
  }

  _remove() {
    setState(() {
      _isDeleting = true;
    });
    _getSetter()(null);
    Navigator.pop(context);
  }

  _getSetter() {
    return Provider.of<AppData>(context, listen: false).setGoal;
  }
}
