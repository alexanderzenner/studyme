import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_chart.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appState, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            InterventionCard(intervention: appState.trial.a),
            InterventionCard(intervention: appState.trial.b),
            ListView.builder(
                shrinkWrap: true,
                itemCount: appState.trial.measures.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      MeasureChart(
                        measure: appState.trial.measures[index],
                        trial: appState.trial,
                        timeAggregation: TimeAggregation.Day,
                      ),
                      MeasureChart(
                        measure: appState.trial.measures[index],
                        trial: appState.trial,
                        timeAggregation: TimeAggregation.Intervention,
                      )
                    ],
                  );
                }),
          ],
        ),
      );
    });
  }
}
