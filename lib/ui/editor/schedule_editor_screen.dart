import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/widgets/schedule_widget.dart';

class ScheduleEditorScreen extends StatefulWidget {
  @override
  _ScheduleEditorScreenState createState() => _ScheduleEditorScreenState();
}

class _ScheduleEditorScreenState extends State<ScheduleEditorScreen> {
  int phaseDuration;
  List<String> phaseSequence;

  @override
  void initState() {
    final trial = Provider.of<AppState>(context, listen: false).trial;
    phaseDuration = trial.phaseDuration;
    phaseSequence = trial.phaseSequence;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit Schedule')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<AppState>(builder: (context, model, child) {
            return Column(
              children: [
                ScheduleWidget(phaseDuration, phaseSequence),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: phaseDuration.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      phaseDuration = int.parse(text);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Phase Duration'),
                ),
              ],
            );
          }),
        ));
  }
}
