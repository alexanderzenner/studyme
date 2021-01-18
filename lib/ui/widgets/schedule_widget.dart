import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/trial_schedule.dart';

class ScheduleWidget extends StatelessWidget {
  final TrialSchedule schedule;

  ScheduleWidget(this.schedule);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: schedule.phaseSequence.length + 1,
          itemBuilder: (context, index) {
            if (index == schedule.phaseSequence.length) {
              return _buildStackedCard(
                  Icon(Icons.flag),
                  Text(
                    '= ${schedule.phaseDuration * schedule.phaseSequence.length}d',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ));
            } else {
              return _buildStackedCard(
                  Text(schedule.phaseSequence[index].toUpperCase(),
                      style: TextStyle(
                          color: schedule.phaseSequence[index] == 'a'
                              ? Colors.lightBlue
                              : Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Text((schedule.phaseDuration.toString() + 'd'),
                      overflow: TextOverflow.ellipsis));
            }
          },
        ),
      ),
    );
  }

  _buildStackedCard(Widget cardChild, Widget belowCardChild) {
    return Container(
      width: 50,
      child: Column(children: [
        Container(height: 50, child: Card(child: Center(child: cardChild))),
        belowCardChild
      ]),
    );
  }
}
