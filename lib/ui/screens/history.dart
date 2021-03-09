import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/time_aggregation.dart';
import 'package:studyme/ui/widgets/phase_card.dart';
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
    _timeAggregation = TimeAggregation.Day;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appState, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PhaseCard(phase: appState.trial.a),
              PhaseCard(phase: appState.trial.b),
              DropdownButtonFormField<TimeAggregation>(
                decoration: InputDecoration(labelText: 'Average per'),
                value: _timeAggregation,
                onChanged: _changeTimeAggregation,
                items: [
                  TimeAggregation.Day,
                  TimeAggregation.Segment,
                  TimeAggregation.Phase,
                ].map<DropdownMenuItem<TimeAggregation>>((value) {
                  return DropdownMenuItem<TimeAggregation>(
                    value: value,
                    child: Text(value.readable),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 120)
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
