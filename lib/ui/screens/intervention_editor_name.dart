import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

import '../widgets/action_button.dart';
import 'schedule_editor.dart';

class InterventionEditorName extends StatefulWidget {
  final Intervention intervention;
  final Function(Intervention intervention) onSave;
  final bool save;

  const InterventionEditorName(
      {@required this.intervention,
      @required this.onSave,
      @required this.save});

  @override
  _InterventionEditorNameState createState() => _InterventionEditorNameState();
}

class _InterventionEditorNameState extends State<InterventionEditorName> {
  String _name;

  @override
  void initState() {
    _name = widget.intervention.name;
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
              Text(Intervention.getTitleFor(_name)),
              Visibility(
                visible: true,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: widget.save ? Icons.check : Icons.arrow_forward,
                canPress: _canSubmit(),
                onPressed: _submit)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                HintCard(titleText: "Set Intervention Name", body: [
                  Text(
                      "Choose a short name that describes the Intervention for you. Some suggested formats are \"Do X\" or \"Take Y\".")
                ]),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofocus: _name == null,
                  initialValue: _name,
                  onChanged: _changeName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _name != null && _name.length > 0;
  }

  _submit() {
    widget.intervention.name = _name;
    widget.save
        ? widget.onSave(widget.intervention)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: widget.intervention.name,
                  objectWithSchedule: widget.intervention,
                  onSave: widget.onSave),
            ));
  }

  _changeName(text) {
    setState(() {
      _name = text;
    });
  }
}
