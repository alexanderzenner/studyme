import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';

import '../../routes.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome to StudyMe", style: TextStyle(fontSize: 30)),
                  Text("Compare Interventions"),
                  Text("StudyMe let's you evaluate interventions."),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InterventionLetter(isA: true),
                      Text("vs."),
                      InterventionLetter(
                        isA: false,
                      )
                    ],
                  ),
                  Text(
                      "An Intervention is anything you can do to reach your desired outcome."),
                  Text(
                      "To know if an intervention is actually working we use measures"),
                  Text("A measure tells you if ...")
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AppData>(context, listen: false)
              .saveAppState(AppState.CREATING);
          Navigator.pushReplacementNamed(context, Routes.creator);
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
