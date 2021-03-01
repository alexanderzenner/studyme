import 'package:flutter/material.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/hints.dart';

class GoalEditorOutcome extends StatefulWidget {
  final String outcome;
  final Function(String outcome) onSave;

  GoalEditorOutcome({this.outcome, this.onSave});

  @override
  _GoalEditorOutcomeState createState() => _GoalEditorOutcomeState();
}

class _GoalEditorOutcomeState extends State<GoalEditorOutcome> {
  String _outcome;

  @override
  void initState() {
    _outcome = widget.outcome;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            ActionButton(
                icon: Icons.check,
                canPress: _canSubmit(),
                onPressed: () => widget.onSave(_outcome)),
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
                  autofocus: _outcome == null,
                  initialValue: _outcome,
                  onChanged: _changeOutcome,
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _outcome != null && _outcome.length > 0;
  }

  _changeOutcome(String value) {
    setState(() {
      _outcome = value;
    });
  }
}
