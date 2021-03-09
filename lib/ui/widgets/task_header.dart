import 'package:flutter/material.dart';
import 'package:studyme/models/task/task.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class TaskHeader extends StatelessWidget {
  final Task task;

  TaskHeader({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.alarm),
              SizedBox(width: 10),
              Text(task.time.readable,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 5),
          Text(task.title, style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
