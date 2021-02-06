import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_chart.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  TimeAggregation _timeAggregation;

  @override
  initState() {
    super.initState();
    _timeAggregation = TimeAggregation.Intervention;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appState, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InterventionCard(intervention: appState.trial.a),
              InterventionCard(intervention: appState.trial.b),
              DropdownButtonFormField<TimeAggregation>(
                decoration: InputDecoration(labelText: 'Aggregate by'),
                value: _timeAggregation,
                onChanged: _changeTimeAggregation,
                items: [
                  TimeAggregation.Day,
                  TimeAggregation.Phase,
                  TimeAggregation.Intervention
                ].map<DropdownMenuItem<TimeAggregation>>((value) {
                  return DropdownMenuItem<TimeAggregation>(
                    value: value,
                    child: Text(value.readable),
                  );
                }).toList(),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: appState.trial.measures.length,
                  itemBuilder: (context, index) {
                    return MeasureChart(
                      measure: appState.trial.measures[index],
                      trial: appState.trial,
                      timeAggregation: _timeAggregation,
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }

  _changeTimeAggregation(TimeAggregation selectedAggregation) {
    setState(() {
      _timeAggregation = selectedAggregation;
    });
  }
}
