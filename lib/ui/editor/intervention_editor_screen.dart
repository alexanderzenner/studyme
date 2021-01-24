import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/abstract_intervention.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/ui/widgets/save_button.dart';

class InterventionEditorScreen extends StatefulWidget {
  final bool isA;
  final AbstractIntervention intervention;

  const InterventionEditorScreen(
      {@required this.isA, @required this.intervention});

  @override
  _InterventionEditorScreenState createState() =>
      _InterventionEditorScreenState();
}

class _InterventionEditorScreenState extends State<InterventionEditorScreen> {
  AbstractIntervention _intervention;

  @override
  initState() {
    _intervention = widget.intervention.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isA ? "Set A" : "Set B"),
          actions: <Widget>[
            SaveButton(
                canPress: _canSubmit(),
                onPressed: () {
                  Navigator.pop(context, _intervention);
                })
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                if (!widget.isA)
                  ToggleButtons(
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
                if (!_isNullIntervention())
                  Column(
                    children: [
                      TextFormField(
                        initialValue: _intervention.name,
                        onFieldSubmitted: _changeName,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextFormField(
                        initialValue: _intervention.description,
                        onFieldSubmitted: _changeDescription,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _intervention.name != null && _intervention.name.length > 0;
  }

  _changeName(text) {
    setState(() {
      _intervention.name = text;
    });
  }

  _changeDescription(text) {
    setState(() {
      _intervention.description = text;
    });
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
