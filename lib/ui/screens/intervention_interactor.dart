import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/task_header.dart';

class InterventionInteractor extends StatefulWidget {
  final InterventionTask task;

  InterventionInteractor(this.task);

  @override
  _InterventionInteractorState createState() => _InterventionInteractorState();
}

class _InterventionInteractorState extends State<InterventionInteractor> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.task.intervention.name),
        actions: <Widget>[
          ActionButton(
              icon: Icons.check,
              canPress: _confirmed,
              onPressed: _markCompleted)
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TaskHeader(task: widget.task),
              SwitchListTile(
                title: Text("Done"),
                value: _confirmed,
                onChanged: (value) {
                  setState(() {
                    _confirmed = value;
                  });
                },
              )
            ],
          )),
    );
  }

  _markCompleted() {
    var now = DateTime.now();
    Provider.of<LogData>(context, listen: false).addCompletedTaskLog(
        CompletedTaskLog(taskId: widget.task.id, dateTime: now));
    Navigator.pop(context, true);
  }
}
