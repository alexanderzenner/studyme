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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Intervention',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Card(
              margin: EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                title: Text(_currentIntervention.name,
                    style:
                        TextStyle(color: false ? Colors.grey : Colors.black)),
                onTap: () =>
                    _navigateToInterventionScreen(_currentIntervention),
              )),
          SizedBox(height: 10),
          Text('Measures',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ...trial.measures
              .map((measure) => Card(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                      title: Text(measure.name),
                      onTap: () => _navigateToMeasureScreen(measure))))
              .toList()
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index > 0) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.insert_chart),
              label: 'Results',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ]),
    );
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
      print(log.value);
    }
  }
}
