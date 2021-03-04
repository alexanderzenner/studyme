import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/util/util.dart';

class MeasureEditorScale extends StatefulWidget {
  final ScaleMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorScale(
      {@required this.measure, @required this.onSave, @required this.save});

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
              Text(widget.measure.name),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Define your scale',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _min.toInt().toString(),
                  onChanged: _updateMin,
                  decoration: InputDecoration(labelText: 'Min'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _max.toInt().toString(),
                  onChanged: _updateMax,
                  decoration: InputDecoration(labelText: 'Max'),
                ),
              ],
            ),
          ),
        ));
  }

  _updateMin(text) {
    textToDoubleSetter(text, (double number) {
      setState(() {
        _min = number;
      });
    });
  }

  _updateMax(text) {
    textToDoubleSetter(text, (double number) {
      setState(() {
        _max = number;
      });
    });
  }

  _canSubmit() {
    return _min < _max;
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
                  title: widget.measure.name,
                  objectWithSchedule: widget.measure,
                  onSave: widget.onSave),
            ));
  }
}
