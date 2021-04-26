import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/ui/screens/trial_type_editor.dart';
import 'package:studyme/ui/screens/intervention_library.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';

import '../screens/intervention_overview.dart';

class CreatorInterventionSection extends StatelessWidget {
  final AppData model;
  final bool isActive;

  CreatorInterventionSection(this.model, {this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('What you want to try out',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor)),
          if (model.trial.interventionA == null)
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Select'),
                    onPressed: () => _addIntervention(context, true)),
              ],
            ),
          if (model.trial.interventionA != null)
            InterventionCard(
                intervention: model.trial.interventionA,
                showSchedule: true,
                onTap: () => _viewIntervention(context, true)),
          if (_firstInterventionSet()) ...[
            SizedBox(height: 10),
            Text('Compare to something else?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor)),
            if (model.trial.type == null)
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text('Select'),
                      onPressed: () => _navigateToTrialTypeEditor(context)),
                ],
              ),
            if (model.trial.type != null)
              Card(
                child: ListTile(
                  title: Text(
                      model.trial.type == TrialType.reversal ? 'No' : 'Yes'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => _navigateToTrialTypeEditor(context),
                ),
              ),
            if (model.trial.type == TrialType.alternatingTreatment) ...[
              SizedBox(height: 10),
              Text('Compare to',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              if (model.trial.interventionB == null)
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Select'),
                        onPressed: () => _addIntervention(context, false)),
                  ],
                ),
              if (model.trial.interventionB != null)
                InterventionCard(
                    showSchedule: true,
                    intervention: model.trial.interventionB,
                    onTap: () => _viewIntervention(context, false)),
            ]
          ],
        ],
      ),
    );
  }

  _firstInterventionSet() {
    return model.trial.interventionA != null;
  }

  _addIntervention(context, isA) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionLibrary(
          isA: isA,
        ),
      ),
    );
  }

  _viewIntervention(context, isA) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionOverview(isA: isA),
      ),
    );
  }

  _navigateToTrialTypeEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialTypeEditor(
            type: model.trial.type,
            onSave: (TrialType type) {
              model.setTrialType(type);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/creator', (r) => false);
            }),
      ),
    );
  }
}
