import 'package:flutter/material.dart';
import 'package:studyme/models/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final void Function() onTap;

  ReminderCard({this.reminder, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
            title: Text(reminder.time.format(context)),
            trailing: Icon(Icons.chevron_right),
            onTap: onTap));
  }
}
