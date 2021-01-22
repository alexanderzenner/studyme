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
        Text('Interventions', style: TextStyle(fontWeight: FontWeight.bold)),
        _buildInterventionCard('A', Colors.lightBlue, model.trial.a, () {
          _editInterventionA(context, model);
        }),
        _buildInterventionCard('B', Colors.lightGreen, model.trial.b, () {
          _editInterventionB(context, model);
        }),
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

  Widget _buildInterventionCard(title, color, intervention, onTap) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
            title: Row(
              children: [
                Text(title,
                    style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text(intervention.name),
              ],
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: onTap));
  }
}
