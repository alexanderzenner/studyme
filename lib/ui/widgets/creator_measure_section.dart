import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/measure_overview.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class CreatorMeasureSection extends StatelessWidget {
  final AppData model;

  final bool isActive;

  CreatorMeasureSection(this.model, {@required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('Measures',
              action: isActive
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.measure_library))
                  : null),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.trial.measures.length,
            itemBuilder: (context, index) {
              return MeasureCard(
                  showSchedule: true,
                  measure: model.trial.measures[index],
                  onTap: () {
                    _previewMeasure(context, index);
                  });
            },
          ),
        ],
      ),
    );
  }

  _previewMeasure(context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureOverview(isPreview: false, index: index),
      ),
    );
  }
}
