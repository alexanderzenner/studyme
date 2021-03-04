import 'package:flutter/material.dart';
import 'package:studyme/models/outcome.dart';

class OutcomeCard extends StatelessWidget {
  final Outcome outcome;
  final void Function() onTap;

  OutcomeCard({this.outcome, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.star, color: Colors.yellow),
        title: Text(outcome.outcome),
        trailing: onTap != null ? Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }
}
