import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/editor/measure_preview_screen.dart';

class MeasureSection extends StatelessWidget {
  final AppState model;

  MeasureSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Measures',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.trial.measures.length + 1,
          itemBuilder: (context, index) {
            if (index == model.trial.measures.length) {
              return Center(
                child: OutlineButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.measure_library);
                  },
                ),
              );
            } else {
              return Card(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(model.trial.measures[index].icon),
                        SizedBox(width: 10),
                        Text(model.trial.measures[index].name),
                      ],
                    ),
                    onTap: () {
                      _previewMeasure(context, model.trial.measures[index]);
                    },
                  ));
            }
          },
        ),
      ],
    );
  }

  _previewMeasure(context, measure) {
    _navigateToPreview(context, measure).then((result) {
      if (result != null) {
        model.updateMeasure(measure, result);
        Navigator.pop(context);
      }
    });
  }

  Future _navigateToPreview(context, measure) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MeasurePreviewScreen(measure: measure, isAdded: true),
      ),
    );
  }
}
