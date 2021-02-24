import 'package:flutter/material.dart';
import 'package:studyme/models/measure/aggregations.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

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
              ChoiceCard<ValueAggregation>(
                  value: ValueAggregation.Average,
                  selectedValue: _aggregation,
                  title: Text(ValueAggregation.Average.readable),
                  onSelect: _changeAggregationType),
              ChoiceCard<ValueAggregation>(
                  value: ValueAggregation.Sum,
                  selectedValue: _aggregation,
                  title: Text(ValueAggregation.Sum.readable),
                  onSelect: _changeAggregationType),
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
