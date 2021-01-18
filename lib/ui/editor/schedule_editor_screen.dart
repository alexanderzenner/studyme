import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';

class ScheduleEditorScreen extends StatefulWidget {
  @override
  _ScheduleEditorScreenState createState() => _ScheduleEditorScreenState();
}

class _ScheduleEditorScreenState extends State<ScheduleEditorScreen> {
  TrialSchedule _schedule;

  @override
  void initState() {
    final trial = Provider.of<AppState>(context, listen: false).trial;
    _schedule = trial.schedule.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Schedule'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<AppState>(context, listen: false)
                    .updateSchedule(_schedule);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<AppState>(builder: (context, model, child) {
            return Column(
              children: [
                ScheduleWidget(_schedule),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: _schedule.phaseDuration.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    int value = int.parse(text);
                    if (value != null && value > 0) {
                      setState(() {
                        _schedule.phaseDuration = value;
                      });
                    }
                  },
                  decoration: InputDecoration(labelText: 'Phase Duration'),
                ),
                TextFormField(
                  initialValue: _schedule.numberOfCycles.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      _schedule.updateNumberOfCycles(int.parse(text));
                    });
                  },
                  decoration: InputDecoration(labelText: 'Number of Cycles'),
                ),
                DropdownButtonFormField<PhaseOrder>(
                  decoration: InputDecoration(labelText: 'Phase Order'),
                  value: _schedule.phaseOrder,
                  onChanged: (phaseOrder) {
                    setState(() {
                      _schedule.updatePhaseOrder(phaseOrder);
                    });
                  },
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
}
