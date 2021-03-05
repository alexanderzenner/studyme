import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/trial_schedule_editor.dart';
import 'package:studyme/ui/widgets/hightlighted_action_button.dart';
import 'package:studyme/ui/widgets/phase_card.dart';

class CreatorSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Experiment Schedule'),
          brightness: Brightness.dark,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                              icon: Icon(Icons.edit),
                              label: Text("Edit Schedule"),
                              onPressed: () =>
                                  _navigateToScheduleEditor(context)),
                        ],
                      ),
                      Card(
                          child: ListTile(
                              leading: Icon(Icons.run_circle),
                              title: Text("Start"),
                              trailing: Text('Today'))),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.trial.schedule.phaseSequence.length,
                        itemBuilder: (context, index) {
                          String letter =
                              model.trial.schedule.phaseSequence[index];
                          Phase _phase =
                              letter == 'a' ? model.trial.a : model.trial.b;
                          return PhaseCard(
                              phase: _phase,
                              showSchedule: true,
                              trailing: Text(
                                  'for ${model.trial.schedule.phaseDuration} days'));
                        },
                      ),
                      Card(
                          child: ListTile(
                              leading: Icon(Icons.flag),
                              title: Text("End"),
                              trailing: Text(
                                  "after ${model.trial.schedule.totalDuration} days"))),
                      SizedBox(height: 30),
                      Center(
                        child: HighlightedActionButton(
                            icon: Icons.check,
                            labelText: 'Start Experiment',
                            onPressed: () => _startTrial(context, model)),
                      ),
                      SizedBox(height: 60),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  _navigateToScheduleEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialScheduleEditor(),
      ),
    );
  }

  _startTrial(context, model) {
    Provider.of<AppData>(context, listen: false)
        .addStepLogForSurvey('start trial');
    model.startTrial();
    Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (r) => false);
  }
}
