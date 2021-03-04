import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/default_outcomes.dart';
import 'package:studyme/models/outcome.dart';
import 'package:studyme/ui/screens/outcome_editor.dart';
import 'package:studyme/ui/screens/outcome_preview.dart';
import 'package:studyme/ui/widgets/library_create_button.dart';
import 'package:studyme/ui/widgets/outcome_card.dart';

class OutcomeLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      List<Outcome> outcomes = defaultOutcomes;
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
              LibraryCreateButton(onPressed: () => _createOutcome(context)),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: outcomes.length,
                  itemBuilder: (context, index) {
                    Outcome _outcome = outcomes[index];
                    return OutcomeCard(
                        outcome: _outcome,
                        onTap: () => _previewOutcome(context, _outcome));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _previewOutcome(context, Outcome outcome) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutcomePreview(outcome: outcome),
      ),
    );
  }

  _createOutcome(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OutcomeEditor(
                  outcome: Outcome(),
                  onSave: _getSaveFunction(context),
                )));
  }

  _getSaveFunction(context) {
    return (Outcome outcome) {
      Provider.of<AppData>(context, listen: false).setOutcome(outcome);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };
  }
}
