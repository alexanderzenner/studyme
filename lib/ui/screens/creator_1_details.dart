import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/creator_2_setup.dart';
import 'package:studyme/ui/widgets/hightlighted_action_button.dart';

import '../../routes.dart';
import 'creator_1_section_interventions.dart';
import 'creator_1_section_measures.dart';
import 'creator_1_section_goal.dart';

class CreatorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Experiment Details'),
          brightness: Brightness.dark,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'onboarding') {
                  Navigator.pushReplacementNamed(context, Routes.onboarding);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'onboarding',
                  child: Row(children: [
                    Icon(Icons.repeat, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Repeat app intro')
                  ]),
                ),
              ],
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  CreatorGoalSection(
                    model,
                  ),
                  if (model.canDefineInterventions())
                    CreatorInterventionSection(model),
                  if (model.canDefineMeasures()) CreatorMeasureSection(model),
                  if (model.canStartTrial()) ...[
                    Text('or go to next step:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(height: 5),
                    HighlightedActionButton(
                        icon: Icons.arrow_forward,
                        labelText: 'Set Up Experiment',
                        onPressed: () =>
                            _navigateToCreatorPhases(context, model))
                  ],
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  _navigateToCreatorPhases(BuildContext context, AppData model) {
    model.addStepLogForSurvey('finish editing details');
    model.finishEditingDetails();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatorSetup(),
      ),
    );
  }
}
