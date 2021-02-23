import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

import '../widgets/action_button.dart';
import 'measure_editor_aggregation.dart';
import 'measure_editor_choice.dart';
import 'measure_editor_scale.dart';

class MeasureEditorName extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorName(
      {@required this.measure, @required this.onSave, @required this.save});

  @override
  _MeasureEditorNameState createState() => _MeasureEditorNameState();
}

class _MeasureEditorNameState extends State<MeasureEditorName> {
  String _name;

  @override
  void initState() {
    _name = widget.measure.name;
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
              Text(Measure.getTitleFor(_name)),
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
        body: Padding(
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
        ));
  }

  _canSubmit() {
    return _name != null && _name.length > 0;
  }

  _submit() {
    widget.measure.name = _name;
    if (widget.save) {
      widget.onSave(widget.measure);
    } else {
      if (widget.measure is ChoiceMeasure) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureEditorChoice(
                  measure: widget.measure, onSave: widget.onSave, save: false),
            ));
      } else if (widget.measure is ScaleMeasure) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureEditorScale(
                  measure: widget.measure, onSave: widget.onSave, save: false),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureEditorAggregation(
                  measure: widget.measure, onSave: widget.onSave, save: false),
            ));
      }
    }
  }

  _changeName(text) {
    setState(() {
      _name = text;
    });
  }
}
