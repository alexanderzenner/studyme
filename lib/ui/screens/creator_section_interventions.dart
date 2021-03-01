import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/intervention_editor_number_of.dart';
import 'package:studyme/ui/screens/intervention_library.dart';
import 'package:studyme/ui/widgets/intervention_card_new.dart';
import 'package:studyme/ui/widgets/section_title.dart';

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
          SectionTitle("What I want to try out"),
          if (model.trial.a == null)
            ButtonBar(
              children: [
                OutlineButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Select'),
                    onPressed: () => _addIntervention(context, true)),
              ],
            ),
          if (model.trial.a != null)
            InterventionCardNew(
                intervention: model.trial.a,
                showSchedule: true,
                onTap: () => _viewIntervention(context, true)),
          SectionTitle("Compare to something else?"),
          if (model.trial.numberOfInterventions == null)
            ButtonBar(
              children: [
                OutlineButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Select'),
                    onPressed: _firstInterventionSet()
                        ? () =>
                            _navigateToGoalNumberOfInterventionsEditor(context)
                        : null),
              ],
            ),
          if (model.trial.numberOfInterventions != null)
            Card(
              child: ListTile(
                title:
                    Text(model.trial.numberOfInterventions == 1 ? 'No' : 'Yes'),
                trailing: Icon(Icons.chevron_right),
                onTap: _firstInterventionSet()
                    ? () => _navigateToGoalNumberOfInterventionsEditor(context)
                    : null,
              ),
            ),
          if (model.trial.numberOfInterventions == 2) ...[
            SectionTitle("Compare to"),
            if (model.trial.b == null)
              ButtonBar(
                children: [
                  OutlineButton.icon(
                      icon: Icon(Icons.add),
                      label: Text('Select'),
                      onPressed: _firstInterventionSet()
                          ? () => _addIntervention(context, false)
                          : null),
                ],
              ),
            if (model.trial.b != null)
              InterventionCardNew(
                  showSchedule: true,
                  intervention: model.trial.b,
                  onTap: () => _viewIntervention(context, false)),
          ],
        ],
      ),
    );
  }

  _firstInterventionSet() {
    return model.trial.a != null;
  }

  _viewIntervention(context, isA) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionOverview(isPreview: false, isA: isA),
      ),
    );
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

  _navigateToGoalNumberOfInterventionsEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterventionEditorNumberOf(
            numberOfInterventions: model.trial.numberOfInterventions,
            onSave: (int number) {
              model.setNumberOfInterventions(number);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/creator', (r) => false);
            }),
      ),
    );
  }
}
