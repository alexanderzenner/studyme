import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';

import '../screens/schedule_editor.dart';

class CreatorScheduleSection extends StatelessWidget {
  final AppData model;

  final bool isActive;

  CreatorScheduleSection(this.model, {@required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('Schedule',
              action: IconButton(
                icon:
                    Icon(model.trial.schedule != null ? Icons.edit : Icons.add),
                onPressed: isActive
                    ? () {
                        _navigateToScheduleEditor(context);
                      }
                    : null,
              )),
          if (model.trial.schedule != null)
            ScheduleWidget(schedule: model.trial.schedule, showDuration: true),
        ],
      ),
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
