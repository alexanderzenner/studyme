import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/editor/intervention_editor_screen.dart';

class InterventionSection extends StatelessWidget {
  final AppState model;

  InterventionSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Interventions',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Card(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: ListTile(
                title: Row(
                  children: [
                    Text('A',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text(model.trial.a.name)
                  ],
                ),
                onTap: () {
                  _editInterventionA(context, model);
                })),
        Card(
            margin: EdgeInsets.symmetric(vertical: 2),
            child: ListTile(
                title: Row(
                  children: [
                    Text('B',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text(model.trial.b.name),
                  ],
                ),
                onTap: () {
                  _editInterventionB(context, model);
                })),
      ],
    );
  }

  _editInterventionA(context, model) {
    _navigateToInterventionEditor(context, true, model.trial.a).then((result) {
      if (result != null) {
        model.setInterventionA(result);
      }
    });
  }

  _editInterventionB(context, model) {
    _navigateToInterventionEditor(context, false, model.trial.b).then((result) {
      if (result != null) {
        model.setInterventionB(result);
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
}
