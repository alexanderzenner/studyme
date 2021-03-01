import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/creator_phases.dart';

import 'creator_section_interventions.dart';
import 'creator_section_measures.dart';
import 'creator_section_outcome.dart';

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
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  CreatorGoalSection(
                    model,
                  ),
                  Divider(height: 30),
                  CreatorInterventionSection(model,
                      isActive: model.canDefineInterventions()),
                  Divider(height: 30),
                  CreatorMeasureSection(model,
                      isActive: model.canDefineMeasures()),
                  SizedBox(height: 60),
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
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatorPhases(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
