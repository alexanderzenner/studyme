import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/widgets/creator_phase_section.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class CreatorPhases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Create Trial'),
          brightness: Brightness.dark,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You want to x'),
                      Text('You want to compare x and y '),
                      Text(
                          'You will collect the following data to inform your decision'),
                      SectionTitle(model.trial.numberOfInterventions == 1
                          ? "Does it help? Let's find out"
                          : "What works better? Let's find out"),
                      Text(
                          "To help you find out if bla bla bla you will go through the following phases"),
                      InterventionCard(
                          letter: 'a',
                          intervention: model.trial.a,
                          showSchedule: true),
                      Center(
                        child: Text('vs.'),
                      ),
                      InterventionCard(
                          letter: 'b',
                          intervention: model.trial.b,
                          showSchedule: true),
                      CreatorPhasesSection(model, isActive: true),
                      Text(
                          'You will complete a total of ${model.trial.phases.numberOfPhases} phases. Each phase is ${model.trial.phases.phaseDuration} days long. The trial will take ${model.trial.phases.totalDuration} days.'),
                      SizedBox(height: 100),
                      Center(
                        child: ButtonTheme(
                          minWidth: 100,
                          height: 45,
                          child: RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Colors.green,
                              icon: Icon(Icons.check, color: Colors.white),
                              label: Text(
                                'Start Trial',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              onPressed: () => _startTrial(context, model)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  _startTrial(context, model) {
    model.startTrial();
    Navigator.pushReplacementNamed(context, Routes.dashboard);
  }
}
