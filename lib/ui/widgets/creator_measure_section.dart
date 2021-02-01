import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/section_title.dart';

import '../screens/measure_preview.dart';

class CreatorMeasureSection extends StatelessWidget {
  final AppData model;

  CreatorMeasureSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Measures',
            action: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, Routes.measure_library);
              },
            )),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.trial.measures.length,
          itemBuilder: (context, index) {
            Measure measure = model.trial.measures[index];
            return MeasureCard(
                measure: measure,
                onTap: () {
                  _previewMeasure(context, measure);
                });
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
