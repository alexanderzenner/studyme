import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/schedule/phase_order.dart';
import 'package:studyme/models/schedule/trial_phases.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:studyme/ui/widgets/phases_widget.dart';

class PhaseEditor extends StatefulWidget {
  @override
  _PhaseEditorState createState() => _PhaseEditorState();
}

class _PhaseEditorState extends State<PhaseEditor> {
  TrialPhases _schedule;
  bool _isCreator;

  @override
  void initState() {
    final trial = Provider.of<AppData>(context, listen: false).trial;
    if (trial.phases != null) {
      _isCreator = false;
      _schedule = trial.phases.clone();
    } else {
      _isCreator = true;
      _schedule = TrialPhases.createDefault();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text((_isCreator ? 'Add' : 'Edit') + ' Phases'),
          actions: <Widget>[
            SaveButton(canPress: _canSubmit(), onPressed: _save)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<AppData>(builder: (context, model, child) {
            return Column(
              children: [
                PhasesWidget(schedule: _schedule, showDuration: true),
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
                      child: Text(value.readable),
                    );
                  }).toList(),
                )
              ],
            );
          }),
        ));
  }

  _canSubmit() {
    return _schedule.totalDuration != 0;
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
    Provider.of<AppData>(context, listen: false).updateSchedule(_schedule);
    Navigator.pop(context, true);
  }
}
