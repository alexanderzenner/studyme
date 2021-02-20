import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:studyme/ui/widgets/measure_choice_widget.dart';
import 'package:studyme/ui/widgets/measure_free_widget.dart';
import 'package:studyme/ui/widgets/measure_scale_widget.dart';
import 'package:studyme/ui/widgets/measure_synced_widget.dart';
import 'package:studyme/ui/widgets/save_button.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class MeasureInteractor extends StatefulWidget {
  final MeasureTask task;

  MeasureInteractor(this.task);

  @override
  _MeasureInteractorState createState() => _MeasureInteractorState();
}

class _MeasureInteractorState extends State<MeasureInteractor> {
  num _value;
  bool _canSave;

  @override
  void initState() {
    _value = null;
    _canSave = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(widget.task.measure.name),
          actions: <Widget>[
            SaveButton(canPress: _canSave, onPressed: _logValue)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
              _buildMeasureWidget()
            ],
          ),
        ));
  }

  _buildMeasureWidget() {
    switch (widget.task.measure.runtimeType) {
      case (FreeMeasure):
        return FreeMeasureWidget(widget.task.measure, _updateValue);
      case (ScaleMeasure):
        return ScaleMeasureWidget(widget.task.measure, _updateValue);
      case (ChoiceMeasure):
        return ChoiceMeasureWidget(widget.task.measure, _updateValue);
      case (SyncedMeasure):
        return SyncedMeasureWidget(
            measure: widget.task.measure,
            confirmed: _canSave,
            setCanSave: (value) => setState(() {
                  _canSave = value;
                }));
      default:
        return Text("Hi");
    }
  }

  _updateValue(value) {
    setState(() {
      _value = value;
      _canSave = true;
    });
  }

  _logValue() {
    if (_value != null) {
      var now = DateTime.now();
      var time = DateTime(now.year, now.month, now.day, widget.task.time.hour,
          widget.task.time.minute);
      var log = TrialLog(widget.task.measure.id, time, _value);
      Provider.of<LogData>(context, listen: false)
          .addMeasureLogs([log], widget.task.measure);
    }
    Provider.of<LogData>(context, listen: false)
        .addCompletedTaskId(widget.task.id);
    Navigator.pop(context, true);
  }
}
