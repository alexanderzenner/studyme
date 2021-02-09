import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/phase_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/ui/widgets/task_card.dart';
import 'package:studyme/util/notifications.dart';
import 'package:studyme/util/util.dart';

import '../../routes.dart';

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
      _body = _buildBodyWithTodaysTasks(
          context, _trial.getRemindersForDate(DateTime.now()));
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
          SizedBox(height: 1000),
          PopupMenuButton<Option>(
              icon: Icon(Icons.warning_amber_outlined),
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

  _buildBodyWithTodaysTasks(context, List<Task> todaysTasks) {
    return [
      SectionTitle('Today'),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: todaysTasks.length,
        itemBuilder: (context, index) {
          Task task = todaysTasks[index];
          return TaskCard(task: task);
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
}
