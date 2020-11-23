import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/intervention_screen.dart';

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
            title: Text(_currentIntervention.name, style: TextStyle(color: Colors.grey)),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterventionScreen(_currentIntervention),
                  ))
            },
          )),
          Text('Measures'),
          ...trial.measures.map((measure) => Card(child: ListTile(title: Text(measure.name)))).toList()
        ])));
  }
}
