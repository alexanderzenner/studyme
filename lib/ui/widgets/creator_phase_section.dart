import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/widgets/phases_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';

import '../screens/phase_editor.dart';
import 'hint_card.dart';

class CreatorPhasesSection extends StatelessWidget {
  final AppData model;

  final bool isActive;

  CreatorPhasesSection(this.model, {@required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isActive && !_phasesIsSet())
            HintCard(
              titleText: "Set Phases",
              body: [
                Text(
                    "Next we define the phases you will go through during the trial."),
                Text(''),
                Text("Click on the + below to set the trial's phases.")
              ],
            ),
          SectionTitle('Phases',
              action: IconButton(
                icon: Icon(_phasesIsSet() ? Icons.edit : Icons.add),
                onPressed:
                    isActive ? () => _navigateToScheduleEditor(context) : null,
              )),
          if (_phasesIsSet())
            PhasesWidget(phases: model.trial.phases, showDuration: true),
        ],
      ),
    );
  }

  _phasesIsSet() {
    return model.trial.phases != null;
  }

  _navigateToScheduleEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhaseEditor(),
      ),
    );
  }
}
