import 'package:flutter/material.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

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
          title: Text("Goal"),
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
                HintCard(
                  titleText: "Set Goal",
                ),
                SizedBox(height: 10),
                TextFormField(
                  autofocus: _outcome == null,
                  initialValue: _outcome,
                  onChanged: _changeOutcome,
                  decoration: InputDecoration(
                    labelText: 'Goal',
                  ),
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
