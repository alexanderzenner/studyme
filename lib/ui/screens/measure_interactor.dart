import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/measure_widget.dart';
import 'package:studyme/ui/widgets/task_header.dart';

class MeasureInteractor extends StatefulWidget {
  final MeasureTask task;

  MeasureInteractor(this.task);

  @override
  _MeasureInteractorState createState() => _MeasureInteractorState();
}

class _MeasureInteractorState extends State<MeasureInteractor> {
  num _value;
  bool _confirmed;

  @override
  void initState() {
    _value = null;
    _confirmed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(widget.task.measure.name),
          actions: <Widget>[
            ActionButton(
                icon: Icons.check, canPress: _confirmed, onPressed: _logValue)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TaskHeader(task: widget.task),
              MeasureWidget(
                measure: widget.task.measure,
                updateValue: _updateValue,
                confirmed: _confirmed,
                setConfirmed: (value) => setState(() {
                  _confirmed = value;
                }),
              )
            ],
          ),
        ));
  }

  _updateValue(value) {
    setState(() {
      _value = value;
      _confirmed = value != null ? true : false;
    });
  }

  _logValue() {
    var now = DateTime.now();
    var time = DateTime(now.year, now.month, now.day, widget.task.time.hour,
        widget.task.time.minute);
    if (_value != null) {
      var log = TrialLog(widget.task.measure.id, time, _value);
      Provider.of<LogData>(context, listen: false)
          .addMeasureLogs([log], widget.task.measure);
    }
    Provider.of<LogData>(context, listen: false).addCompletedTaskLog(
        CompletedTaskLog(taskId: widget.task.id, dateTime: now));
    Navigator.pop(context, true);
  }
}
