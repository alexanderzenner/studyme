import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/trial_creator/intervention_section.dart';
import 'package:studyme/ui/trial_creator/measure_section.dart';
import 'package:studyme/ui/trial_creator/schedule_section.dart';

class TrialCreator extends StatefulWidget {
  @override
  _TrialCreatorState createState() => _TrialCreatorState();
}

class _TrialCreatorState extends State<TrialCreator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(title: Text('Create Trial')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                InterventionSection(model),
                SizedBox(height: 10),
                MeasureSection(model),
                SizedBox(height: 10),
                ScheduleSection(model),
                SizedBox(height: 10),
                Center(
                  child: OutlineButton(
                    child: Text('Start trial'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  ),
                )
              ]),
            ),
          ));
    });
  }
}
