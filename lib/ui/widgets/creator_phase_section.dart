import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/widgets/phases_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';

import '../screens/phase_editor.dart';

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
          SectionTitle('Phases',
              action: isActive
                  ? IconButton(
                      icon: Icon(
                          model.trial.phases != null ? Icons.edit : Icons.add),
                      onPressed: () => _navigateToScheduleEditor(context),
                    )
                  : null),
          if (model.trial.phases != null)
            PhasesWidget(phases: model.trial.phases, showDuration: true),
        ],
      ),
    );
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
