import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

import '../widgets/choice_measure_widget.dart';
import '../widgets/free_measure_widget.dart';
import '../widgets/scale_measure_widget.dart';
import 'measure_editor.dart';

class MeasurePreview extends StatelessWidget {
  final Measure measure;
  final bool isAdded;

  const MeasurePreview({@required this.measure, @required this.isAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(measure.name + " (Preview)")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (measure.description != null &&
                    measure.description.length > 0)
                  Text(measure.description),
                _buildPreview(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!isAdded)
                      OutlineButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add to trial"),
                          onPressed: () {
                            _addMeasure(context);
                          }),
                    if (isAdded)
                      OutlineButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Remove"),
                          onPressed: () {
                            _removeMeasure(context);
                          }),
                    if (isAdded && measure.canEdit)
                      OutlineButton.icon(
                          icon: Icon(Icons.edit),
                          label: Text("Edit"),
                          onPressed: () {
                            _editMeasure(context);
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

  _removeMeasure(context) {
    Provider.of<AppData>(context, listen: false).removeMeasure(measure);
    Navigator.pop(context);
  }

  _editMeasure(context) {
    _navigateToEditor(context).then((result) {
      if (result != null) {
        Provider.of<AppData>(context, listen: false)
            .updateMeasure(measure, result);
        Navigator.pop(context);
      }
    });
  }

  Future _navigateToEditor(context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureEditor(isCreator: false, measure: measure),
      ),
    );
  }
}
