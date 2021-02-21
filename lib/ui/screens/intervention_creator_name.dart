import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/screens/intervention_creator_schedule.dart';
import 'package:studyme/ui/widgets/action_button.dart';

class InterventionCreatorName extends StatefulWidget {
  final bool isA;
  final Intervention intervention;
  final Function(Intervention intervention) onSave;

  const InterventionCreatorName(
      {@required this.isA, @required this.intervention, @required this.onSave});

  @override
  _InterventionCreatorNameState createState() =>
      _InterventionCreatorNameState();
}

class _InterventionCreatorNameState extends State<InterventionCreatorName> {
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
              Text(widget.isA ? "Intervention A" : "Intervention B"),
              Visibility(
                visible: true,
                child: Text(
                  'Set Name',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: Icons.arrow_forward,
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionCreatorSchedule(
              isA: widget.isA,
              intervention: widget.intervention,
              onSave: widget.onSave),
        ));
  }

  _changeName(text) {
    setState(() {
      _name = text;
    });
  }
}
