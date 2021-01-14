import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final int phaseDuration;
  final List<String> phaseSequence;

  ScheduleWidget(this.phaseDuration, this.phaseSequence);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: phaseSequence.length + 1,
          itemBuilder: (context, index) {
            if (index == phaseSequence.length) {
              return _buildStackedCard(
                  Icon(Icons.flag),
                  Text('= ${phaseDuration * phaseSequence.length}d',
                      style: TextStyle(fontWeight: FontWeight.bold)));
            } else {
              return _buildStackedCard(
                  Text(phaseSequence[index].toUpperCase(),
                      style: TextStyle(
                          color: phaseSequence[index] == 'a'
                              ? Colors.lightBlue
                              : Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Text(phaseDuration.toString() + 'd'));
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
