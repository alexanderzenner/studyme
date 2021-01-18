import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/editor/measure_editor_screen.dart';
import 'package:studyme/ui/editor/measure_preview_screen.dart';
import 'package:uuid/uuid.dart';

class MeasureLibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Text("Add Measure"),
                  ],
                ),
              ),
              body: ListView.builder(
                itemCount: model.unaddedMeasures().length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Row(
                      children: [
                        Icon(model.unaddedMeasures()[index].icon),
                        SizedBox(width: 10),
                        Text(model.unaddedMeasures()[index].name),
                      ],
                    ),
                    onTap: () {
                      _previewMeasure(
                          context, model, model.unaddedMeasures()[index]);
                    },
                  ));
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _createMeasure(context, model);
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
              ),
            ));
  }

  _previewMeasure(context, model, measure) {
    _navigateToPreview(context, measure).then((result) {
      if (result != null) {
        model.addMeasureToTrial(result);
        Navigator.pop(context);
      }
    });
  }

  Future _navigateToPreview(context, measure) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MeasurePreviewScreen(measure: measure, isAdded: false),
      ),
    );
  }

  _createMeasure(context, model) {
    Measure newMeasure = FreeMeasure()..id = Uuid().v4();
    _navigateToCreator(context, newMeasure).then((result) {
      if (result != null) {
        model.addMeasureToTrial(result);
        Navigator.pop(context);
      }
    });
  }

  Future _navigateToCreator(context, measure) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MeasureEditorScreen(isCreator: true, measure: measure),
      ),
    );
  }
}
