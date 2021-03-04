import 'package:flutter/material.dart';
import 'package:studyme/models/phase/phase_intervention.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/phase/phase_withdrawal.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';

class InterventionCard extends StatelessWidget {
  final Phase phase;
  final bool showSchedule;
  final Widget trailing;
  final void Function() onTap;

  InterventionCard(
      {@required this.phase,
      this.onTap,
      this.showSchedule = false,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: InterventionLetter(phase.letter),
            title: _getTitle(),
            subtitle: _getSubtitle(phase),
            trailing:
                trailing ?? (onTap != null ? Icon(Icons.chevron_right) : null),
            onTap: onTap));
  }

  Widget _getTitle() {
    return phase != null
        ? Text(phase.name,
            style: (phase is WithdrawalPhase)
                ? TextStyle(fontStyle: FontStyle.italic)
                : null)
        : null;
  }

  Widget _getSubtitle(Phase phase) {
    if (phase != null && showSchedule && phase is InterventionPhase) {
      return Text(phase.intervention.schedule.readable);
    } else {
      return null;
    }
  }
}
