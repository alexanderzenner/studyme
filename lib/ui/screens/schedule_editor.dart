import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';

class ScheduleEditor extends StatefulWidget {
  @override
  _ScheduleEditorState createState() => _ScheduleEditorState();
}

class _ScheduleEditorState extends State<ScheduleEditor> {
  TrialSchedule _schedule;
  bool _isCreator;

  @override
  void initState() {
    final trial = Provider.of<AppState>(context, listen: false).trial;
    if (trial.schedule != null) {
      _isCreator = false;
      _schedule = trial.schedule.clone();
    } else {
      _isCreator = true;
      _schedule = TrialSchedule.createDefault();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text((_isCreator ? 'Add' : 'Edit') + ' Schedule'),
          actions: <Widget>[
            SaveButton(canPress: _canSubmit(), onPressed: _save)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<AppState>(builder: (context, model, child) {
            return Column(
              children: [
                ScheduleWidget(schedule: _schedule, showDuration: true),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: _schedule.phaseDuration.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: _updatePhaseDuration,
                  decoration: InputDecoration(labelText: 'Phase Duration'),
                ),
                TextFormField(
                  initialValue: _schedule.numberOfCycles.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: _updateNumberOfCycles,
                  decoration: InputDecoration(labelText: 'Number of Cycles'),
                ),
                DropdownButtonFormField<PhaseOrder>(
                  decoration: InputDecoration(labelText: 'Phase Order'),
                  value: _schedule.phaseOrder,
                  onChanged: _updatePhaseOrder,
                  items: [PhaseOrder.alternating, PhaseOrder.counterbalanced]
                      .map<DropdownMenuItem<PhaseOrder>>((value) {
                    return DropdownMenuItem<PhaseOrder>(
                      value: value,
                      child: Text(value.humanReadable),
                    );
                  }).toList(),
                )
              ],
            );
          }),
        ));
  }

  _canSubmit() {
    return _schedule.duration != 0;
  }

  _updateNumberOfCycles(text) {
    _update(text, (int number) {
      setState(() {
        _schedule.updateNumberOfCycles(number);
      });
    });
  }

  _updatePhaseDuration(text) {
    _update(text, (int number) {
      setState(() {
        _schedule.phaseDuration = number;
      });
    });
  }

  _update(text, setterFunction) {
    try {
      int value = text.length > 0 ? int.parse(text) : 0;
      setterFunction(value);
    } on Exception catch (_) {
      print("Invalid number");
    }
  }

  _updatePhaseOrder(phaseOrder) {
    setState(() {
      _schedule.updatePhaseOrder(phaseOrder);
    });
  }

  _save() {
    Provider.of<AppState>(context, listen: false).updateSchedule(_schedule);
    Navigator.pop(context, true);
  }
}
