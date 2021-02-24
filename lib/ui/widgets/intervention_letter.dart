import 'package:flutter/material.dart';
import 'package:studyme/util/color_map.dart';

class InterventionLetter extends StatelessWidget {
  final String letter;
  final bool isInverted;

  InterventionLetter(this.letter, {this.isInverted = false});

  @override
  Widget build(BuildContext context) {
    return Text(letter.toUpperCase(),
        style: TextStyle(
            color: isInverted ? Colors.white : letterColorMap[letter],
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }
}
