import 'package:flutter/material.dart';

class InterventionLetter extends StatelessWidget {
  final bool isA;

  InterventionLetter({@required this.isA});

  @override
  Widget build(BuildContext context) {
    return Text(isA ? 'A' : 'B',
        style: TextStyle(
            color: isA ? Colors.lightBlue : Colors.lightGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }
}
