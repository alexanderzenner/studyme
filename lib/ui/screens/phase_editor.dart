import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/phases/phase_order.dart';
import 'package:studyme/models/phases/phases.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/phases_widget.dart';
import 'package:studyme/util/util.dart';

class PhaseEditor extends StatefulWidget {
  @override
  _PhaseEditorState createState() => _PhaseEditorState();
}

class _PhaseEditorState extends State<PhaseEditor> {
  Phases _schedule;

  @override
  void initState() {
    final trial = Provider.of<AppData>(context, listen: false).trial;
    if (trial.phases != null) {
      _schedule = trial.phases.clone();
    } else {
      _schedule = Phases.createDefault();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text('Phases'),
          actions: <Widget>[
            ActionButton(
                icon: Icons.check, canPress: _canSubmit(), onPressed: _save)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<AppData>(builder: (context, model, child) {
              return Column(
                children: [
                  HintCard(
                    titleText: "Set Phases",
                    body: [
                      Text('Note:',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      Text(
                          '\u2022 The phases are paired, meaning for every A phase there is a B phase.',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      Text(
                          '\u2022 Under the flag in the phase overview below you can see the total duration of your trial.',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                  SizedBox(height: 10),
                  PhasesWidget(phases: _schedule, showDuration: true),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _schedule.phaseDuration.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: _updatePhaseDuration,
                    decoration:
                        InputDecoration(labelText: 'Phase Duration (in days)'),
                  ),
                  TextFormField(
                    initialValue: _schedule.numberOfCycles.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: _updateNumberOfCycles,
                    decoration: InputDecoration(labelText: 'Number of Pairs'),
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
          ),
        ));
  }

  _canSubmit() {
    return _schedule.totalDuration > 0 &&
        _schedule.totalDuration < 1000 &&
        _schedule.phaseDuration <= 365 &&
        _schedule.numberOfCycles < 100;
  }

  _updateNumberOfCycles(text) {
    textToIntSetter(text, (int number) {
      setState(() {
        _schedule.updateNumberOfCycles(number);
      });
    });
  }

  _updatePhaseDuration(text) {
    textToIntSetter(text, (int number) {
      setState(() {
        _schedule.phaseDuration = number;
      });
    });
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
