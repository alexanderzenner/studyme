import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/screens/creator_schedule.dart';
import 'package:studyme/ui/widgets/action_button.dart';

class InterventionCreatorName extends StatefulWidget {
  final String title;
  final Intervention intervention;
  final Function(Intervention intervention) onSave;
  final bool save;

  const InterventionCreatorName(
      {@required this.title,
      @required this.intervention,
      @required this.onSave,
      @required this.save});

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
              Text(widget.title),
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
              builder: (context) => CreatorSchedule(
                  title: widget.title,
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
