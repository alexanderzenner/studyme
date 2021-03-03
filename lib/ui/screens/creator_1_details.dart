import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/creator_2_setup.dart';

import 'creator_1_section_interventions.dart';
import 'creator_1_section_measures.dart';
import 'creator_1_section_outcome.dart';

class CreatorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Experiment Details'),
          brightness: Brightness.dark,
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
                  SizedBox(height: 30),
                  if (model.canDefineInterventions())
                    CreatorInterventionSection(model),
                  SizedBox(height: 30),
                  if (model.canDefineMeasures()) CreatorMeasureSection(model),
                  SizedBox(height: 60),
                ]),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: model.canStartTrial()
              ? () => _navigateToCreatorPhases(context, model)
              : null,
          icon: Icon(Icons.arrow_forward),
          label: Text('Set Up Experiment'),
          backgroundColor: model.canStartTrial() ? Colors.green : null,
        ),
      );
    });
  }

  _navigateToCreatorPhases(BuildContext context, AppData model) {
    model.finishEditingDetails();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatorSetup(),
      ),
    );
  }
}
