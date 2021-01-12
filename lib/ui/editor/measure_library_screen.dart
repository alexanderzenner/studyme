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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Add Measure"),
          ],
        ),
      ),
      body: Consumer<AppState>(
          builder: (context, model, child) => ListView.builder(
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
                      _previewMeasure(context, model.unaddedMeasures()[index]);
                    },
                  ));
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createMeasure(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  _previewMeasure(context, measure) {
    _navigateToPreview(context, measure).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false).addMeasureToTrial(result);
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

  _createMeasure(context) {
    Measure newMeasure = FreeMeasure()..id = Uuid().v4();
    _navigateToCreator(context, newMeasure).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false).addMeasureToTrial(result);
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
