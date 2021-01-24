import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';

import '../screens/schedule_editor.dart';

class ScheduleSection extends StatelessWidget {
  final AppState model;

  ScheduleSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
        ScheduleWidget(model.trial.schedule),
        Center(
          child: OutlineButton(
            padding: EdgeInsets.zero,
            child: Icon(Icons.edit, size: 20),
            onPressed: () {
              _navigateToScheduleEditor(context);
            },
          ),
        )
      ],
    );
  }

  _navigateToScheduleEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleEditor(),
      ),
    );
  }
}
