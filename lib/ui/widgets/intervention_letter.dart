import 'package:flutter/material.dart';

class InterventionLetter extends StatelessWidget {
  final bool isA;
  final bool isInverted;

  InterventionLetter({@required this.isA, this.isInverted = false});

  @override
  Widget build(BuildContext context) {
    return Text(isA ? 'A' : 'B',
        style: TextStyle(
            color: isInverted
                ? Colors.white
                : isA
                    ? Colors.lightBlue
                    : Colors.lightGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }
}
