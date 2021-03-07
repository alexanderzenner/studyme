import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/default_interventions.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/ui/screens/intervention_preview.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/library_create_button.dart';

import 'intervention_editor_name.dart';

class InterventionLibrary extends StatelessWidget {
  final bool isA;

  InterventionLibrary({@required this.isA});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                  isA
                      ? "What is one thing you want to try out to achieve your goal?"
                      : 'What is the other thing you want to try out?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              LibraryCreateButton(
                  onPressed: () => _createIntervention(context)),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text('Suggestions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                    if (model.trial.outcome.suggestedInterventions.length == 0)
                      HintCard(
                          titleText:
                              'No suggestions for "${model.trial.outcome.outcome}" available'),
                    if (model.trial.outcome.suggestedInterventions.length > 0)
                      _buildListWith(
                          model.trial.outcome.suggestedInterventions),
                    SizedBox(height: 10),
                    Text('Other',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                    _buildListWith(defaultInterventions)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _buildListWith(List<Intervention> interventions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: interventions.length,
      itemBuilder: (context, index) {
        Intervention _intervention = interventions[index];
        return InterventionCard(
            intervention: _intervention,
            onTap: () => _previewIntervention(context, _intervention));
      },
    );
  }

  _previewIntervention(context, Intervention intervention) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InterventionPreview(isA: isA, intervention: intervention),
      ),
    );
  }

  _createIntervention(BuildContext context) {
    Function saveFunction = (Intervention intervention) {
      _getSetter(context)(intervention);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionEditorName(
            intervention: Intervention(),
            isA: isA,
            onSave: saveFunction,
            save: false),
      ),
    );
  }

  _getSetter(BuildContext context) {
    return isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}
