import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/phase_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/util/notifications.dart';
import 'package:studyme/util/util.dart';

import '../../routes.dart';
import 'intervention_interactor.dart';
import 'measure_interactor.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Notifications().debugShowPendingRequests();

    final Trial _trial = Provider.of<AppData>(context).trial;
    final _dateToday = DateTime.now();

    List<Widget> _body;
    int _activeIndex;

    if (_dateToday.isBefore(_trial.startDate)) {
      _body = _buildBodyWithTrialHasNotStartedMessage();
      _activeIndex = -1;
    } else if (_dateToday.isAfter(_trial.endDate)) {
      _body = _buildBodyWithTrialIsEndedMessage();
      _activeIndex = _trial.phases.totalDuration;
    } else {
      final _currentIntervention = _trial.getInterventionForDate(_dateToday);
      _body = _buildBodyWithTodaysTasks(context, _trial, _currentIntervention);
      _activeIndex = _trial.getPhaseIndexForDate(_dateToday);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          PhasesWidget(schedule: _trial.phases, activeIndex: _activeIndex),
          SizedBox(height: 20),
          ..._body,
          PopupMenuButton<Option>(
              onSelected: (Option option) {
                option.callback();
              },
              itemBuilder: (context) => [
                    Option(
                        name: 'Edit trial (Debug)',
                        callback: () {
                          Provider.of<AppData>(context, listen: false)
                              .debugCancelAllNotifications();
                          Provider.of<AppData>(context, listen: false)
                              .saveAppState(AppState.CREATING);
                          Navigator.pushReplacementNamed(
                              context, Routes.onboarding);
                        }),
                    Option(
                        name: 'Cancel trial',
                        callback: () {
                          Provider.of<AppData>(context, listen: false)
                              .debugCancelAllNotifications();
                          Provider.of<AppData>(context, listen: false)
                              .createNewTrial();
                          Navigator.pushReplacementNamed(
                              context, Routes.onboarding);
                        })
                  ]
                      .map((option) => PopupMenuItem<Option>(
                          value: option, child: Text(option.name)))
                      .toList())
        ]),
      ),
    );
  }

  _buildBodyWithTodaysTasks(context, trial, currentIntervention) {
    return [
      SectionTitle('Intervention'),
      InterventionCard(
          intervention: currentIntervention,
          onTap: () =>
              _navigateToInterventionScreen(context, currentIntervention)),
      SizedBox(height: 10),
      SectionTitle('Measures'),
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

  _buildBodyWithTrialHasNotStartedMessage() {
    return [Text("Trial hasn't started yet")];
  }

  _buildBodyWithTrialIsEndedMessage() {
    return [Text("Trial has ended")];
  }

  _navigateToInterventionScreen(context, intervention) async {
    bool completed = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterventionInteractor(intervention)));
    if (completed != null && completed) {
      Util.toast(context, "Saved");
    }
  }

  _navigateToMeasureScreen(context, measure) async {
    bool didLog = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureInteract(measure)));
    if (didLog != null && didLog) {
      Util.toast(context, "Saved");
    }
  }
}
