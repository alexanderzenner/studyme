import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';

import 'intervention_interactor.dart';
import 'measure_interactor.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trial = Provider.of<AppState>(context).trial;
    final _currentIntervention = trial.getInterventionForDate(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ScheduleWidget(schedule: trial.schedule),
        SizedBox(height: 10),
        Text('Intervention', style: TextStyle(fontWeight: FontWeight.bold)),
        InterventionCard(
            isA: _currentIntervention.isA,
            intervention: _currentIntervention.intervention,
            onTap: () => _navigateToInterventionScreen(
                context, _currentIntervention.intervention)),
        SizedBox(height: 10),
        Text('Measures', style: TextStyle(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: trial.measures.length,
          itemBuilder: (context, index) {
            Measure measure = trial.measures[index];
            return MeasureCard(
                measure: measure,
                onTap: () {
                  _navigateToMeasureScreen(context, measure);
                });
          },
        ),
      ]),
    );
  }

  _navigateToInterventionScreen(context, intervention) async {
    final completed = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterventionInteractor(intervention)));
    print(completed);
  }

  _navigateToMeasureScreen(context, measure) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureInteract(measure)));
  }
}
