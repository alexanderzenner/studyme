import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/widgets/action_button.dart';

import 'schedule_editor.dart';

class MeasureEditorScale extends StatefulWidget {
  final String title;
  final ScaleMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorScale(
      {@required this.title,
      @required this.measure,
      @required this.onSave,
      @required this.save});

  @override
  _MeasureEditorScaleState createState() => _MeasureEditorScaleState();
}

class _MeasureEditorScaleState extends State<MeasureEditorScale> {
  double _min;
  double _max;

  @override
  void initState() {
    _min = widget.measure.min;
    _max = widget.measure.max;
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
                  'Scale',
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _min.toInt().toString(),
                  onChanged: (text) {
                    setState(() {
                      _min = double.parse(text);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Min'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _max.toInt().toString(),
                  onChanged: (text) {
                    setState(() {
                      _max = double.parse(text);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Max'),
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    print((_max - _min).abs());
    return (_max - _min).abs() > 0;
  }

  _submit() {
    widget.measure.min = _min;
    widget.measure.max = _max;
    widget.save
        ? widget.onSave(widget.measure)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: widget.title,
                  objectWithSchedule: widget.measure,
                  onSave: widget.onSave),
            ));
  }
}
