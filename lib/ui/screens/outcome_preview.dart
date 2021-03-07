import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/outcome.dart';

class OutcomePreview extends StatelessWidget {
  final Outcome outcome;

  OutcomePreview({@required this.outcome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(outcome.outcome),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: Text("Goal"),
                  subtitle:
                      Text(outcome.outcome, style: TextStyle(fontSize: 16)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text("Add to Experiment"),
                        onPressed: () => _addOutcome(context)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addOutcome(BuildContext context) {
    Provider.of<AppData>(context, listen: false).setOutcome(outcome);
    Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
  }
}
