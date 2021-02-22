import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/ui/widgets/measure_choice_widget.dart';
import 'package:studyme/ui/widgets/measure_free_widget.dart';
import 'package:studyme/ui/widgets/measure_scale_widget.dart';
import 'package:studyme/ui/widgets/measure_synced_widget.dart';

class MeasurePreview extends StatelessWidget {
  final Measure measure;
  final bool isAdded;

  const MeasurePreview({@required this.measure, @required this.isAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.dark,
            title: Text(measure.name + " (Preview)")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (measure.description != null &&
                    measure.description.length > 0)
                  Text(measure.description),
                _buildPreview(),
                ButtonBar(
                  children: [
                    if (!isAdded)
                      OutlineButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add to trial"),
                          onPressed: () {
                            _addMeasure(context);
                          }),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _buildPreview() {
    switch (measure.runtimeType) {
      case FreeMeasure:
        return FreeMeasureWidget(measure, null);
        break;
      case ChoiceMeasure:
        return ChoiceMeasureWidget(measure, null);
      case ScaleMeasure:
        return ScaleMeasureWidget(measure, null);
      case SyncedMeasure:
        return SyncedMeasureWidget(measure: measure);
      default:
        return Text('HI');
    }
  }

  _addMeasure(context) {
    measure.canAdd.then((value) {
      if (value) {
        Navigator.pop(context, measure);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Access denied. In order for StudyMe to track your ${measure.name} automatically you need to grant permissions.")));
      }
    });
  }
}
