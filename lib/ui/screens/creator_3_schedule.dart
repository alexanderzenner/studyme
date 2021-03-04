import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/phase_editor.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';

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
                        itemCount: model.trial.phases.phaseSequence.length,
                        itemBuilder: (context, index) {
                          String letter =
                              model.trial.phases.phaseSequence[index];
                          Intervention _intervention =
                              letter == 'a' ? model.trial.a : model.trial.b;
                          return Card(
                              child: ListTile(
                                  leading: InterventionLetter(letter),
                                  title: Text(_intervention.name),
                                  subtitle: _intervention.schedule != null
                                      ? Text(_intervention.schedule.readable)
                                      : null,
                                  trailing: Text(
                                      'for ${model.trial.phases.phaseDuration} days')));
                        },
                      ),
                      Card(
                          child: ListTile(
                              leading: Icon(Icons.flag),
                              title: Text("End"),
                              trailing: Text(
                                  "after ${model.trial.phases.totalDuration} days"))),
                      SizedBox(height: 60),
                    ]),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _startTrial(context, model),
          icon: Icon(Icons.check),
          label: Text('Start Experiment'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  _navigateToScheduleEditor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhaseEditor(),
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
