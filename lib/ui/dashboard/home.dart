import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';

import '../intervention_screen.dart';
import '../measure_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trial = Provider.of<AppState>(context, listen: false).trial;
    final _currentIntervention = trial.getInterventionForDate(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Intervention',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Card(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: ListTile(
              title: Text(_currentIntervention.name,
                  style: TextStyle(color: false ? Colors.grey : Colors.black)),
              onTap: () =>
                  _navigateToInterventionScreen(context, _currentIntervention),
            )),
        SizedBox(height: 10),
        Text('Measures',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ...trial.measures
            .map((measure) => Card(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                    title: Text(measure.name),
                    onTap: () => _navigateToMeasureScreen(context, measure))))
            .toList()
      ]),
    );
  }

  _navigateToInterventionScreen(context, intervention) async {
    final completed = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterventionScreen(intervention)));
    print(completed);
  }

  _navigateToMeasureScreen(context, measure) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureScreen(measure)));
  }
}
