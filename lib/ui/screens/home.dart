import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';

import 'intervention_interactor.dart';
import 'measure_interactor.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trial = Provider.of<AppState>(context).trial;
    final _currentIntervention = trial.getInterventionForDate(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Intervention', style: TextStyle(fontWeight: FontWeight.bold)),
        Card(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: ListTile(
              title: Text(_currentIntervention.name,
                  style: TextStyle(color: Colors.black)),
              onTap: () =>
                  _navigateToInterventionScreen(context, _currentIntervention),
            )),
        SizedBox(height: 10),
        Text('Measures', style: TextStyle(fontWeight: FontWeight.bold)),
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
            builder: (context) => InterventionInteractor(intervention)));
    print(completed);
  }

  _navigateToMeasureScreen(context, measure) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureInteract(measure)));
  }
}