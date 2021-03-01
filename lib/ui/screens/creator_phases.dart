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
                child: Column(children: [
                  SectionTitle('What works better?'),
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
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: 100,
                    height: 45,
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        color: Colors.green,
                        icon: Icon(Icons.check, color: Colors.white),
                        label: Text(
                          'Done',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () => print("hi")),
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
