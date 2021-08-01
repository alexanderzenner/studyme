import 'package:flutter/material.dart';
import 'package:studyme/models/measure/automatic_measure.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

class AutomaticMeasureWidget extends StatelessWidget {
  final AutomaticMeasure measure;

  final bool confirmed;

  final void Function(bool) setConfirmed;

  AutomaticMeasureWidget({this.measure, this.confirmed, this.setConfirmed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: Text("I entered the data in my Google Fit / Apple Health app"),
          value: confirmed,
          onChanged: setConfirmed,
        ),
        SizedBox(height: 20),
        if (confirmed)
          HintCard(titleText: 'Restart app to fetch values', body: [
            Text(
                "The newest values will be automatically fetched when you restart the app")
          ]),
      ],
    );
  }
}
