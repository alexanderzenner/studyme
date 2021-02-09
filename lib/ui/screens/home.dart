import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/phases_widget.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/ui/widgets/task_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Trial _trial = Provider.of<AppData>(context).trial;
    final _dateToday = DateTime.now().add(Duration(days: 0));

    List<Widget> _body;
    int _activeIndex;

    if (_dateToday.isBefore(_trial.startDate)) {
      _body = _buildBeforeStartBody(_trial);
      _activeIndex = -1;
    } else if (_dateToday.isAfter(_trial.endDate)) {
      _body = _buildAfterEndBody(_trial);
      _activeIndex = _trial.phases.totalDuration;
    } else {
      _body = _buildBodyWithTodaysTasks(
          context, _trial.getTasksForDate(_dateToday));
      _activeIndex = _trial.getPhaseIndexForDate(_dateToday);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          PhasesWidget(schedule: _trial.phases, activeIndex: _activeIndex),
          ..._body,
        ]),
      ),
    );
  }

  _buildBodyWithTodaysTasks(context, List<Task> todaysTasks) {
    return [
      SectionTitle('Today'),
      if (todaysTasks.length > 0)
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: todaysTasks.length,
          itemBuilder: (context, index) {
            Task task = todaysTasks[index];
            return TaskCard(task: task);
          },
        ),
      if (!todaysTasks.any((element) => element is InterventionTask))
        HintCard(
          title: "No intervention today!",
        ),
      if (todaysTasks.length == 0)
        HintCard(
          title: "No tasks today!",
        ),
    ];
  }

  _buildBeforeStartBody(Trial trial) {
    return [
      SizedBox(height: 20),
      HintCard(
          title:
              "Your trial will start on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(trial.startDate)}")
    ];
  }

  _buildAfterEndBody(Trial trial) {
    return [
      SizedBox(height: 20),
      HintCard(
          title:
              "Your trial ended on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(trial.endDate)}")
    ];
  }
}
