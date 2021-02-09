import 'package:flutter/material.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/ui/screens/intervention_interactor.dart';
import 'package:studyme/ui/screens/measure_interactor.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
          leading: Text(task.time.readable),
          title: Text(task.title),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _select(context),
        ));
  }

  _select(context) {
    if (task is InterventionTask) {
      InterventionTask _task = task as InterventionTask;
      _navigateToInterventionScreen(context, _task);
    } else if (task is MeasureTask) {
      MeasureTask _task = task as MeasureTask;
      _navigateToMeasureScreen(context, _task);
    }
  }

  _navigateToInterventionScreen(context, InterventionTask intervention) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterventionInteractor(intervention)));
  }

  _navigateToMeasureScreen(context, MeasureTask task) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureInteractor(task)));
  }
}
