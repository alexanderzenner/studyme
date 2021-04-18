import 'package:flutter/material.dart';
import 'package:studyme/models/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;
  final void Function() onTap;

  GoalCard({this.goal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.star, color: Colors.yellow),
        title: Text(goal.goal),
        trailing: onTap != null ? Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }
}
