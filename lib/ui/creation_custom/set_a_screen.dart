import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/widgets/intervention_editor.dart';

class SetAScreen extends StatelessWidget {
  void saveAndGoToNextPage(context, intervention) {
    Provider.of<AppState>(context, listen: false).setInterventionA(intervention);
    Navigator.pushNamed(context, '/set_b');
  }

  @override
  Widget build(BuildContext context) {
    Intervention _intervention = Provider.of<AppState>(context, listen: false).trial?.a ?? Intervention();

    return Scaffold(
        appBar: AppBar(
          title: Text("Set A"),
        ),
        body: Column(
          children: [
            InterventionEditor(intervention: _intervention),
            OutlineButton(
              child: Text('Ok'),
              onPressed: () => saveAndGoToNextPage(context, _intervention),
            ),
          ],
        ));
  }
}
