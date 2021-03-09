import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';

import '../widgets/action_button.dart';

class MeasureEditorUnit extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorUnit(
      {@required this.measure, @required this.onSave, @required this.save});

  @override
  _MeasureEditorUnitState createState() => _MeasureEditorUnitState();
}

class _MeasureEditorUnitState extends State<MeasureEditorUnit> {
  String _unit;

  @override
  void initState() {
    _unit = widget.measure.unit;
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
              Text(widget.measure.name),
              Visibility(
                visible: true,
                child: Text(
                  'Unit',
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter the unit your data is measured in',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: _unit == null,
                initialValue: _unit,
                onChanged: _changeUnit,
                decoration: InputDecoration(
                  labelText: 'Unit',
                ),
              ),
            ],
          ),
        ));
  }

  _canSubmit() {
    return _unit != null && _unit.length > 0;
  }

  _submit() {
    widget.measure.unit = _unit;
    if (widget.save) {
      widget.onSave(widget.measure);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleEditor(
                title: widget.measure.name,
                objectWithSchedule: widget.measure,
                onSave: widget.onSave),
          ));
    }
  }

  _changeUnit(text) {
    setState(() {
      _unit = text;
    });
  }
}
