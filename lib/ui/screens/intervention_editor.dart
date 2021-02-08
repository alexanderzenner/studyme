import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:studyme/ui/widgets/schedule_editor_section.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class InterventionEditor extends StatefulWidget {
  final bool isA;
  final Intervention intervention;

  const InterventionEditor({@required this.isA, @required this.intervention});

  @override
  _InterventionEditorState createState() => _InterventionEditorState();
}

class _InterventionEditorState extends State<InterventionEditor> {
  Intervention _intervention;

  @override
  initState() {
    _intervention = widget.intervention.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(widget.isA ? "Set A" : "Set B"),
          actions: <Widget>[
            SaveButton(
                canPress: _canSubmit(),
                onPressed: () {
                  Navigator.pop(context, _intervention);
                })
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
                if (!widget.isA) _buildTypeToggle(),
                if (!_isNullIntervention())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle("Intervention"),
                      TextFormField(
                        autofocus: _intervention.name == null,
                        initialValue: _intervention.name,
                        onChanged: _changeName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      Divider(height: 30),
                      ScheduleEditorSection(schedule: _intervention.schedule)
                    ],
                  ),
              ],
            ),
          ),
        ));
  }

  _buildTypeToggle() {
    return Center(
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
    );
  }

  _canSubmit() {
    return _intervention.name != null &&
        _intervention.name.length > 0 &&
        (_intervention is NoIntervention ||
            _intervention.schedule.times.length > 0);
  }

  _changeName(text) {
    setState(() {
      _intervention.name = text;
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
