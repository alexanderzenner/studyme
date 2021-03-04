import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/phases_widget.dart';
import 'package:studyme/ui/widgets/task_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // listen to log data so screen is rebuilt when logs are added
    Provider.of<LogData>(context);
    final Trial _trial = Provider.of<AppData>(context).trial;
    final _dateToday = DateTime.now().add(Duration(days: 0));

    Widget _body;
    int _activeIndex;

    if (_dateToday.isBefore(_trial.startDate)) {
      _body = _buildBeforeStartBody(_trial);
      _activeIndex = -1;
    } else if (_dateToday.isAfter(_trial.endDate)) {
      _body = _buildAfterEndBody(_trial);
      _activeIndex = _trial.phases.totalDuration;
    } else {
      _body = _buildActiveBody(context, _trial, _dateToday);
      _activeIndex = _trial.getPhaseIndexForDate(_dateToday);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          PhasesWidget(phases: _trial.phases, activeIndex: _activeIndex),
          _body,
        ]),
      ),
    );
  }

  _buildActiveBody(BuildContext context, Trial trial, DateTime date) {
    Intervention _intervention = trial.getInterventionForDate(date);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InterventionCard(
          letter: _intervention.letter, intervention: _intervention),
      SizedBox(height: 20),
      Text('Today',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor)),
      TaskList(trial: trial, date: date),
    ]);
  }

  _buildBeforeStartBody(Trial trial) {
    return Column(children: [
      SizedBox(height: 20),
      HintCard(titleText: "Experiment hasn't started yet", body: [
        Text(
            "Your experiment will start on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(trial.startDate)}")
      ])
    ]);
  }

  _buildAfterEndBody(Trial trial) {
    return Column(children: [
      SizedBox(height: 20),
      HintCard(titleText: "Trial ended", body: [
        Text(
            "Your experiment ended on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(trial.endDate)}")
      ])
    ]);
  }
}
