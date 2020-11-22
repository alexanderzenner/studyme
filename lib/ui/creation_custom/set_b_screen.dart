import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/widgets/intervention_editor.dart';

class SetInterventionScreen extends StatelessWidget {
  void saveAndGoToNextPage(context, intervention) {
    Provider.of<AppState>(context, listen: false).setInterventionB(intervention);
    Navigator.pushNamed(context, '/measure_overview');
  }

  @override
  Widget build(BuildContext context) {
    Intervention _intervention = Provider.of<AppState>(context, listen: false).trial?.b ?? Intervention();

    return Scaffold(
        appBar: AppBar(
          title: Text("Set B"),
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
