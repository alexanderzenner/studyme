import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/editor/intervention_editor_screen.dart';
import 'package:studyme/ui/editor/measure_preview_screen.dart';

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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildInterventionSection(model),
                    SizedBox(height: 10),
                    ..._buildMeasuresSection(model),
                    SizedBox(height: 10),
                    _buildScheduleSection(),
                    SizedBox(height: 200),
                    Center(
                      child: OutlineButton(
                        child: Text('Sounds good'),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        },
                      ),
                    )
                  ]),
            ),
          ));
    });
  }

  _buildInterventionSection(model) {
    return [
      Text('Interventions',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      Card(
          margin: EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
              title: Text(model.trial.a.name),
              onTap: () {
                _editInterventionA(context, model);
              })),
      Card(
          margin: EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
              title: Text(model.trial.b.name),
              onTap: () {
                _editInterventionB(context, model);
              })),
    ];
  }

  _buildMeasuresSection(model) {
    return [
      Text('Measures',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.trial.measures.length + 1,
        itemBuilder: (context, index) {
          if (index == model.trial.measures.length) {
            return Center(
              child: RaisedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/measure_library');
                },
              ),
            );
          } else {
            return Card(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(model.trial.measures[index].icon),
                      SizedBox(width: 10),
                      Text(model.trial.measures[index].name),
                    ],
                  ),
                  onTap: () {
                    _previewMeasure(context, model.trial.measures[index]);
                  },
                ));
          }
        },
      ),
    ];
  }

  _buildScheduleSection() {
    return Text('Schedule',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
  }

  _editInterventionA(context, model) {
    _navigateToInterventionEditor(context, true, model.trial.a).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false).setInterventionA(result);
      }
    });
  }

  _editInterventionB(context, model) {
    _navigateToInterventionEditor(context, false, model.trial.b).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false).setInterventionB(result);
      }
    });
  }

  Future _navigateToInterventionEditor(context, isA, intervention) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InterventionEditorScreen(isA: isA, intervention: intervention),
      ),
    );
  }

  _previewMeasure(context, measure) {
    _navigateToPreview(context, measure).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false)
            .updateMeasure(measure, result);
        Navigator.pop(context);
      }
    });
  }

  Future _navigateToPreview(context, measure) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MeasurePreviewScreen(measure: measure, isAdded: true),
      ),
    );
  }
}
