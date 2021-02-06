import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

import '../widgets/creator_intervention_section.dart';
import '../widgets/creator_measure_section.dart';
import '../widgets/creator_reminder_section.dart';
import '../widgets/creator_phase_section.dart';

class Creator extends StatelessWidget {
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
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  HintCard(),
                  CreatorInterventionSection(model),
                  Divider(height: 30),
                  CreatorPhasesSection(model, isActive: model.canAddSchedule()),
                  Divider(height: 30),
                  CreatorMeasureSection(model,
                      isActive: model.canAddMeasures()),
                  Divider(height: 30),
                  CreatorReminderSection(model,
                      isActive: model.canAddReminders()),
                  SizedBox(height: 60),
                ]),
              ),
            ),
          ),
        ),
        floatingActionButton: model.canStartTrial()
            ? FloatingActionButton.extended(
                onPressed: () {
                  model.startTrial();
                  Navigator.pushReplacementNamed(context, Routes.dashboard);
                },
                icon: Icon(Icons.check),
                label: Text('Start trial'),
                backgroundColor: Colors.green,
              )
            : null,
      );
    });
  }
}
