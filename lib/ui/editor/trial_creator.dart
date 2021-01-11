import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/editor/intervention_editor_screen.dart';

class TrialCreator extends StatefulWidget {
  @override
  _TrialCreatorState createState() => _TrialCreatorState();
}

class _TrialCreatorState extends State<TrialCreator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(title: Text('Trial Creator')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Interventions', style: TextStyle(fontSize: 20)),
              Card(
                  child: ListTile(
                      title: Text(model.trial.a.name),
                      onTap: () {
                        _editInterventionA(context, model);
                      })),
              Card(
                  child: ListTile(
                      title: Text(model.trial.b.name),
                      onTap: () {
                        _editInterventionB(context, model);
                      })),
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
            ]),
          ));
    });
  }

  _editInterventionA(context, model) {
    _navigateToEditor(context, true, model.trial.a).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false).setInterventionA(result);
      }
    });
  }

  _editInterventionB(context, model) {
    _navigateToEditor(context, false, model.trial.b).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false).setInterventionB(result);
      }
    });
  }

  Future _navigateToEditor(context, isA, intervention) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InterventionEditorScreen(isA: isA, intervention: intervention),
      ),
    );
  }
}
