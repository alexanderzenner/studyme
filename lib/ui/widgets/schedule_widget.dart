import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';

class ScheduleWidget extends StatelessWidget {
  final TrialSchedule schedule;
  final bool showDuration;

  ScheduleWidget({@required this.schedule, this.showDuration = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showDuration ? 70 : 50,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: schedule.phaseSequence.length + 1,
          itemBuilder: (context, index) {
            Widget _cardContent;
            Widget _textBelowCard;

            if (index == schedule.phaseSequence.length) {
              _cardContent = Icon(Icons.flag);
              if (showDuration) {
                _textBelowCard = _buildTotalDurationText();
              }
            } else {
              _cardContent =
                  InterventionLetter(isA: schedule.phaseSequence[index] == 'a');
              if (showDuration) {
                _textBelowCard = _buildPhaseDurationText();
              }
            }

            return _buildStackedCard(_cardContent, _textBelowCard);
          },
        ),
      ),
    );
  }

  _buildTotalDurationText() {
    return Text(
      '= ${schedule.phaseDuration * schedule.phaseSequence.length}d',
      style: TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildPhaseDurationText() {
    return Text((schedule.phaseDuration.toString() + 'd'),
        overflow: TextOverflow.ellipsis);
  }

  _buildStackedCard(Widget cardChild, Widget belowCardChild) {
    return Container(
      width: 50,
      child: Column(children: [
        Container(height: 50, child: Card(child: Center(child: cardChild))),
        if (belowCardChild != null) belowCardChild
      ]),
    );
  }
}
