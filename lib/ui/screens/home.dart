import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/schedule_widget.dart';

import 'intervention_interactor.dart';
import 'measure_interactor.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Trial _trial = Provider.of<AppState>(context).trial;
    final _dateToday = DateTime.now();

    List<Widget> _body;
    int _activeIndex;

    if (_dateToday.isBefore(_trial.getEndDate())) {
      final _currentIntervention = _trial.getInterventionForDate(_dateToday);
      _body = _buildBodyWithTodaysTasks(context, _trial, _currentIntervention);
      _activeIndex = _trial.getInterventionIndexForDate(_dateToday);
    } else {
      _body = _buildBodyWithTrialIsEndedMessage();
      _activeIndex = _trial.schedule.duration;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        ScheduleWidget(schedule: _trial.schedule, activeIndex: _activeIndex),
        SizedBox(height: 20),
        ..._body
      ]),
    );
  }

  _buildBodyWithTodaysTasks(context, trial, currentIntervention) {
    return [
      Text('Intervention', style: TextStyle(fontWeight: FontWeight.bold)),
      InterventionCard(
          isA: currentIntervention.isA,
          intervention: currentIntervention.intervention,
          onTap: () => _navigateToInterventionScreen(
              context, currentIntervention.intervention)),
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
    ];
  }

  _buildBodyWithTrialIsEndedMessage() {
    return [Text("Trial has ended")];
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
