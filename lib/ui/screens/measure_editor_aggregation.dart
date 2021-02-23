import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/action_button.dart';

import 'package:studyme/models/measure/aggregations.dart';

class MeasureEditorAggregation extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorAggregation(
      {@required this.measure, @required this.onSave, @required this.save});

  @override
  _MeasureEditorAggregationState createState() =>
      _MeasureEditorAggregationState();
}

class _MeasureEditorAggregationState extends State<MeasureEditorAggregation> {
  ValueAggregation _aggregation;

  @override
  void initState() {
    _aggregation = widget.measure.aggregation;
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
              Text(widget.measure.title),
              Visibility(
                visible: true,
                child: Text(
                  'Aggregation',
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
                canPress: true,
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
              DropdownButtonFormField<ValueAggregation>(
                decoration: InputDecoration(labelText: 'Aggregation'),
                onChanged: _changeAggregationType,
                value: _aggregation,
                items: ValueAggregation.values
                    .map((aggregation) => DropdownMenuItem<ValueAggregation>(
                        value: aggregation, child: Text(aggregation.readable)))
                    .toList(),
              )
            ],
          ),
        ));
  }

  _changeAggregationType(ValueAggregation aggregation) {
    setState(() {
      _aggregation = aggregation;
    });
  }

  _submit() {
    widget.measure.aggregation = _aggregation;
    widget.save
        ? widget.onSave(widget.measure)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: widget.measure.title,
                  objectWithSchedule: widget.measure,
                  onSave: widget.onSave),
            ));
  }
}
