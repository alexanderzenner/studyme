import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/log/measure_log.dart';
import 'package:studyme/ui/intervention_screen.dart';
import 'package:studyme/ui/measure_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final trial = Provider.of<AppState>(context, listen: false).trial;
    final _currentIntervention = trial.getInterventionForDate(DateTime.now());

    return Scaffold(
        appBar: AppBar(
          title: Text('Today\'s Schedule'),
        ),
        body: Center(
            child: Column(children: [
          Text('Intervention'),
          Card(
              child: ListTile(
            title: Text(_currentIntervention.name,
                style: TextStyle(color: false ? Colors.grey : Colors.black)),
            onTap: () => _navigateToInterventionScreen(_currentIntervention),
          )),
          Text('Measures'),
          ...trial.measures
              .map((measure) => Card(
                  child: ListTile(
                      title: Text(measure.name),
                      onTap: () => _navigateToMeasureScreen(measure))))
              .toList()
        ])));
  }

  _navigateToInterventionScreen(intervention) async {
    final completed = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterventionScreen(intervention)));
    print(completed);
  }

  _navigateToMeasureScreen(measure) async {
    final completed = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureScreen(measure)));
    if (completed != null) {
      final log = MeasureLog()..value = completed;
      print(log);
    }
  }
}
