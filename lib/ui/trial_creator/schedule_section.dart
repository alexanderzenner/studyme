import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/editor/schedule_editor_screen.dart';
import 'package:studyme/widgets/schedule_widget.dart';

class ScheduleSection extends StatelessWidget {
  final AppState model;

  ScheduleSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Schedule',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        GestureDetector(
            onTap: () => _navigateToScheduleEditor(context),
            child: ScheduleWidget(
                model.trial.phaseDuration, model.trial.phaseSequence))
      ],
    );
  }

  _navigateToScheduleEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleEditorScreen(),
      ),
    );
  }
}
