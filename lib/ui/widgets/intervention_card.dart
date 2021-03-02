import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';

class InterventionCard extends StatelessWidget {
  final String letter;
  final Intervention intervention;
  final bool showSchedule;
  final void Function() onTap;

  InterventionCard(
      {@required this.letter,
      @required this.intervention,
      this.onTap,
      this.showSchedule = false});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: InterventionLetter(letter),
            title: _getTitle(),
            subtitle: _getSubtitle(),
            trailing: onTap != null ? Icon(Icons.chevron_right) : null,
            onTap: onTap));
  }

  Widget _getTitle() {
    print(intervention is NoIntervention);
    return intervention != null
        ? Text(intervention.name,
            style: (intervention is NoIntervention)
                ? TextStyle(fontStyle: FontStyle.italic)
                : null)
        : null;
  }

  Widget _getSubtitle() {
    if (intervention != null && showSchedule && intervention.schedule != null) {
      return Text(intervention.schedule.readable);
    } else {
      return null;
    }
  }
}
