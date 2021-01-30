import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/title_text.dart';

import '../screens/measure_preview.dart';

class TrialCreatorMeasureSection extends StatelessWidget {
  final AppState model;

  TrialCreatorMeasureSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText('Measures'),
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
              Measure measure = model.trial.measures[index];
              return MeasureCard(
                  measure: measure,
                  onTap: () {
                    _previewMeasure(context, measure);
                  });
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
      }
    });
  }

  Future _navigateToPreview(context, measure) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasurePreview(measure: measure, isAdded: true),
      ),
    );
  }
}
