import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrialCreator extends StatefulWidget {
  @override
  _TrialCreatorState createState() => _TrialCreatorState();
}

class _TrialCreatorState extends State<TrialCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Trial Creator')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Interventions', style: TextStyle(fontSize: 20)),
            Card(child: ListTile(title: Text('Intervention 1'))),
            Card(child: ListTile(title: Text('Intervention 2'))),
            Text('Measures', style: TextStyle(fontSize: 20)),
            Center(
              child: RaisedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/measure_library');
                },
              ),
            ),
            Text('Schedule', style: TextStyle(fontSize: 20)),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                )
              ],
            )
          ]),
        ));
  }
}
