import 'package:flutter/material.dart';

import 'hint_card.dart';

class Hints {
  static HintCard goalEditorHint = HintCard(
    titleText: 'Set Goal',
    body: [
      Text(
          "Your goal should be something you want to improve about your health or well-being."),
      Text("Complete this sentence to create a descriptive goal:"),
      Text(" I want to...", style: TextStyle(fontStyle: FontStyle.italic)),
    ],
  );
}
