import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/routes.dart';

import '../widgets/trial_creator_intervention_section.dart';
import '../widgets/trial_creator_measure_section.dart';
import '../widgets/trial_creator_reminder_section.dart';
import '../widgets/trial_creator_schedule_section.dart';

class TrialCreator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(title: Text('Create Trial')),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  TrialCreatorInterventionSection(model),
                  Divider(height: 40),
                  TrialCreatorMeasureSection(model),
                  Divider(height: 40),
                  TrialCreatorScheduleSection(model),
                  Divider(height: 40),
                  TrialCreatorReminderSection(model),
                  Divider(height: 40),
                  Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      child: OutlineButton(
                        child: Text('Start trial'),
                        onPressed: model.trial.isReady
                            ? () {
                                model.startTrial();
                                Navigator.pushReplacementNamed(
                                    context, Routes.dashboard);
                              }
                            : null,
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ));
    });
  }
}
