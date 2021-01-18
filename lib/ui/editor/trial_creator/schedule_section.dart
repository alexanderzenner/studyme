import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/editor/schedule_editor_screen.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';

class ScheduleSection extends StatelessWidget {
  final AppState model;

  ScheduleSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Schedule',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Container(
              width: 40,
              height: 20,
              child: OutlineButton(
                padding: EdgeInsets.zero,
                child: Icon(Icons.edit, size: 20),
                onPressed: () {
                  _navigateToScheduleEditor(context);
                },
              ),
            )
          ],
        ),
        ScheduleWidget(model.trial.schedule),
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
