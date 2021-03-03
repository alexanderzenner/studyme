import 'package:flutter/material.dart';
import 'package:studyme/models/outcome.dart';
import 'package:studyme/ui/widgets/action_button.dart';

class OutcomeEditor extends StatefulWidget {
  final Outcome outcome;
  final Function(Outcome outcome) onSave;

  OutcomeEditor({@required this.outcome, @required this.onSave});

  @override
  _OutcomeEditorState createState() => _OutcomeEditorState();
}

class _OutcomeEditorState extends State<OutcomeEditor> {
  String _outcome;

  @override
  void initState() {
    _outcome = widget.outcome.outcome;
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
                onPressed: () => widget.onSave(Outcome(outcome: _outcome))),
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
