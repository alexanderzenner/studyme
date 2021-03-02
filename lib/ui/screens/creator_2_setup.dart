import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/creator_3_schedule.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/intervention_card_new.dart';
import 'package:studyme/ui/widgets/measure_card.dart';

class CreatorSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Experiment'),
          brightness: Brightness.dark,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You will collect the following data:',
                          style: TextStyle(fontSize: 20)),
                      ...model.trial.measures
                          .map((measure) => MeasureCard(measure: measure))
                          .toList(),
                      Text('to see if', style: TextStyle(fontSize: 20)),
                      InterventionCardNew(intervention: model.trial.a),
                      if (model.trial.numberOfInterventions == 2) ...[
                        Text('or', style: TextStyle(fontSize: 20)),
                        InterventionCardNew(intervention: model.trial.b),
                      ],
                      Text('helps you to achieve your goal',
                          style: TextStyle(fontSize: 20)),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.star, color: Colors.yellow),
                          title: Text(model.trial.outcome),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                          'To do this, we will compare your data from two different phases:',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 20),
                      InterventionCard(
                          letter: 'a',
                          intervention: model.trial.a,
                          showSchedule: true),
                      Center(
                        child: Text('vs.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                      ),
                      InterventionCard(
                          letter: 'b',
                          intervention: model.trial.b,
                          showSchedule: true),
                      SizedBox(height: 20),
                      Text(
                          'You will complete a series of these phases, and in each phase you do either A or B.',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 100),
                    ]),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToCreatorPhases(context, model),
          icon: Icon(Icons.arrow_forward),
          label: Text('Schedule Experiment'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  _navigateToCreatorPhases(BuildContext context, AppData model) {
    model.finishEditingDetails();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatorSchedule(),
      ),
    );
  }
}
