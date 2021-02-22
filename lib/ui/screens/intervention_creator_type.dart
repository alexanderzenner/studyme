import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';

import '../widgets/action_button.dart';
import 'intervention_editor_name.dart';

class InterventionCreatorType extends StatefulWidget {
  final String title;
  final Function(Intervention intervention) onSave;

  const InterventionCreatorType({@required this.title, @required this.onSave});

  @override
  _InterventionCreatorTypeState createState() =>
      _InterventionCreatorTypeState();
}

class _InterventionCreatorTypeState extends State<InterventionCreatorType> {
  Intervention _intervention;

  @override
  initState() {
    _intervention = NoIntervention();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title),
              Visibility(
                visible: true,
                child: Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: _isNullIntervention() ? Icons.check : Icons.arrow_forward,
                canPress: _canSubmit(),
                onPressed: _submit)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ToggleButtons(
                    children: <Widget>[
                      Padding(
                        child: Text("No Intervention"),
                        padding: const EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: Text("Intervention"),
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ],
                    onPressed: _changeInterventionType,
                    isSelected: [_isNullIntervention(), !_isNullIntervention()],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return true;
  }

  _submit() {
    _isNullIntervention()
        ? widget.onSave(_intervention)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InterventionEditorName(
                  title: widget.title,
                  intervention: _intervention,
                  onSave: widget.onSave,
                  save: false),
            ));
  }

  _changeInterventionType(int index) {
    setState(() {
      if (index == 0) {
        _intervention = NoIntervention();
      } else if (index != 0) {
        _intervention = Intervention();
      }
    });
  }

  _isNullIntervention() {
    return _intervention is NoIntervention;
  }
}
