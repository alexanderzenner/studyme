import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/creation_custom/measure_editor_screen.dart';
import 'package:uuid/uuid.dart';

class MeasureOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Choose Measures"),
          ],
        ),
      ),
      body: Consumer<AppState>(
          builder: (context, model, child) => ListView.builder(
                itemCount: model.trial.measures.length + 1,
                itemBuilder: (context, index) {
                  if (index == model.trial.measures.length) {
                    return OutlineButton(
                      child: Text('Sounds good', style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      },
                    );
                  }
                  return Card(
                      child: ListTile(
                    title: Row(
                      children: [
                        Icon(model.trial.measures[index].icon),
                        SizedBox(width: 10),
                        Text(model.trial.measures[index].name),
                      ],
                    ),
                    onTap: () {
                      _navigateToEditor(context, model.trial.measures[index]).then((result) {
                        if (result != null) {
                          Provider.of<AppState>(context, listen: false).updateMeasure(index, result);
                        }
                      });
                    },
                  ));
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Measure newMeasure = FreeMeasure()..id = Uuid().v4();
          _navigateToEditor(context, newMeasure).then((result) {
            if (result != null) {
              Provider.of<AppState>(context, listen: false).addMeasure(result);
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future _navigateToEditor(context, measure) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureEditorScreen(measure: measure),
      ),
    );
  }
}
