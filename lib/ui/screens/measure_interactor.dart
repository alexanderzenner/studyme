import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_state.dart';
import 'package:studyme/models/log/measure_log.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/ui/widgets/choice_measure_widget.dart';
import 'package:studyme/ui/widgets/free_measure_widget.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:studyme/ui/widgets/scale_measure_widget.dart';
import 'package:studyme/ui/widgets/synced_measure_widget.dart';

class MeasureInteract extends StatefulWidget {
  final Measure measure;

  MeasureInteract(this.measure);

  @override
  _MeasureInteractState createState() => _MeasureInteractState();
}

class _MeasureInteractState extends State<MeasureInteract> {
  double _value;

  @override
  void initState() {
    _value = null;
    super.initState();
  }

  _hasSelectedValue() {
    return _value != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.measure.name),
          actions: <Widget>[
            SaveButton(canPress: _hasSelectedValue(), onPressed: _logValue)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildMeasureWidget(),
        ));
  }

  _buildMeasureWidget() {
    switch (widget.measure.runtimeType) {
      case (FreeMeasure):
        return FreeMeasureWidget(widget.measure, _updateValue);
      case (ScaleMeasure):
        return ScaleMeasureWidget(widget.measure, _updateValue);
      case (ChoiceMeasure):
        return ChoiceMeasureWidget(widget.measure, _updateValue);
      case (SyncedMeasure):
        return SyncedMeasureWidget(
            measure: widget.measure, updateValue: _updateValue);
      default:
        return Text("Hi");
    }
  }

  _updateValue(value) {
    setState(() {
      _value = value;
    });
  }

  _logValue() {
    var log = MeasureLog(widget.measure.id, DateTime.now(), _value);
    Provider.of<LogState>(context, listen: false).addLog(log);
    Navigator.pop(context);
  }
}
