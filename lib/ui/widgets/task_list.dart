import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/phase/phase_intervention.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/task_card.dart';

class TaskList extends StatefulWidget {
  final Trial trial;
  final DateTime date;

  TaskList({this.trial, this.date});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool _isLoading;

  List<String> _completedTaskIds;

  List<Task> _todaysTasks;

  @override
  void initState() {
    _isLoading = true;
    _todaysTasks = widget.trial.getTasksForDate(widget.date);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadLogs();
  }

  loadLogs() async {
    List<String> _data =
        await Provider.of<LogData>(context).getCompletedTaskIdsFor(widget.date);
    setState(() {
      _completedTaskIds = _data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : _buildTaskList();
  }

  _buildTaskList() {
    Phase _currentPhase = widget.trial.getPhaseForDate(widget.date);
    return Column(
      children: [
        if (_currentPhase is InterventionPhase) ...[
          if (!_todaysTasks.any((element) => element is InterventionTask))
            HintCard(
              titleText: 'No tasks for "${_currentPhase.name}" today!',
            ),
        ],
        if (!_todaysTasks.any((element) => element is MeasureTask))
          HintCard(
            titleText: "No data collected today!",
          ),
        if (_todaysTasks.length > 0)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _todaysTasks.length,
            itemBuilder: (context, index) {
              Task task = _todaysTasks[index];
              return TaskCard(
                task: task,
                isCompleted: _completedTaskIds.contains(task.id),
              );
            },
          ),
      ],
    );
  }
}
