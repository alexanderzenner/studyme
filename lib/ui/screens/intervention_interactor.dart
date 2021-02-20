import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/ui/widgets/save_button.dart';

import 'package:studyme/util/time_of_day_extension.dart';

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
          SaveButton(canPress: _confirmed, onPressed: _markCompleted)
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.alarm),
                    SizedBox(width: 10),
                    Text(widget.task.time.readable),
                  ],
                ),
              ),
              SwitchListTile(
                title: Text("I completed the intervention"),
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
    Provider.of<LogData>(context, listen: false)
        .addCompletedTaskId(widget.task.id);
    Navigator.pop(context, true);
  }
}
