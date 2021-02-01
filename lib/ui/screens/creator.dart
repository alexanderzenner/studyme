import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';

import '../widgets/creator_intervention_section.dart';
import '../widgets/creator_measure_section.dart';
import '../widgets/creator_reminder_section.dart';
import '../widgets/creator_schedule_section.dart';

class Creator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(title: Text('Create Trial')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                MaterialBanner(content: Text("HI"), actions: [
                  FlatButton(
                    child: const Text('ACTION 1'),
                    onPressed: () {},
                  ),
                ]),
                CreatorInterventionSection(model),
                Divider(height: 30),
                MaterialBanner(content: Text("HI"), actions: [
                  FlatButton(
                    child: const Text('ACTION 1'),
                    onPressed: () {},
                  ),
                ]),
                CreatorScheduleSection(model),
                Divider(height: 30),
                CreatorMeasureSection(model),
                Divider(height: 30),
                CreatorReminderSection(model),
                SizedBox(height: 80),
              ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: model.trial.isReady
              ? () {
                  model.startTrial();
                  Navigator.pushReplacementNamed(context, Routes.dashboard);
                }
              : null,
          icon: model.trial.isReady ? Icon(Icons.check) : null,
          label: Text('Start trial'),
          backgroundColor: model.trial.isReady ? Colors.green : Colors.grey,
        ),
      );
    });
  }
}
