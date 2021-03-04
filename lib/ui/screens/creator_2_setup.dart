import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/creator_3_schedule.dart';
import 'package:studyme/ui/widgets/hightlighted_action_button.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/outcome_card.dart';

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
                      Text('You will compare data on',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      ...model.trial.measures
                          .map((measure) => MeasureCard(measure: measure))
                          .toList(),
                      Text('between two different phases*',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
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
                      if (model.trial.numberOfInterventions == 2)
                        Text(
                            'to see if A or B is better for achieving your goal',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                      if (model.trial.numberOfInterventions == 1)
                        Text(
                            'to see if there is a difference** between A or B for achieving your goal',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                      OutcomeCard(
                        outcome: model.trial.outcome,
                      ),
                      SizedBox(height: 20),
                      Text(
                          '* For a good comparison, you will complete a series of the two phases and compare A and B multiple times.',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor)),
                      SizedBox(height: 20),
                      if (model.trial.numberOfInterventions == 1)
                        Text(
                            '** If there is no difference "${model.trial.a.name}" likely doesn\'t help you achieve your goal.',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor)),
                      SizedBox(height: 30),
                      Center(
                        child: HighlightedActionButton(
                            icon: Icons.arrow_forward,
                            labelText: 'Schedule Experiment',
                            onPressed: () =>
                                _navigateToCreatorPhases(context, model)),
                      ),
                      SizedBox(height: 60),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  _navigateToCreatorPhases(BuildContext context, AppData model) {
    Provider.of<AppData>(context, listen: false)
        .addStepLogForSurvey('finish viewing setup');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatorSchedule(),
      ),
    );
  }
}
