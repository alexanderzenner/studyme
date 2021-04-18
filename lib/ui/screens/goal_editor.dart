import 'package:flutter/material.dart';
import 'package:studyme/models/goal.dart';
import 'package:studyme/ui/widgets/action_button.dart';

class GoalEditor extends StatefulWidget {
  final Goal goal;
  final Function(Goal goal) onSave;

  GoalEditor({@required this.goal, @required this.onSave});

  @override
  _GoalEditorState createState() => _GoalEditorState();
}

class _GoalEditorState extends State<GoalEditor> {
  String _goal;

  @override
  void initState() {
    _goal = widget.goal.goal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            ActionButton(
                icon: Icons.check, canPress: _canSubmit(), onPressed: _onSubmit)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                      "What do you want to improve about your health or well-being?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 10),
                Text("I want to...",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor)),
                TextFormField(
                  autofocus: _goal == null,
                  initialValue: _goal,
                  onChanged: _changeGoal,
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _goal != null && _goal.length > 0;
  }

  _onSubmit() {
    widget.onSave(Goal(goal: _goal));
  }

  _changeGoal(String value) {
    setState(() {
      _goal = value;
    });
  }
}
