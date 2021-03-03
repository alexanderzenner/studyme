import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/measure_overview.dart';
import 'package:studyme/ui/widgets/measure_card.dart';

class CreatorMeasureSection extends StatelessWidget {
  final AppData model;

  CreatorMeasureSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Text(
              "Data collected to assess if what your are trying is helping you achieve your goal",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.trial.measures.length,
          itemBuilder: (context, index) {
            return MeasureCard(
                showSchedule: true,
                measure: model.trial.measures[index],
                onTap: () {
                  _viewMeasure(context, index);
                });
          },
        ),
        ButtonBar(
          children: [
            OutlineButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add' +
                    (model.trial.measures.length > 0 ? ' another' : '')),
                onPressed: () => _addMeasure(context)),
          ],
        ),
      ],
    );
  }

  _addMeasure(context) {
    Navigator.pushNamed(context, Routes.measure_library);
  }

  _viewMeasure(context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureOverview(isPreview: false, index: index),
      ),
    );
  }
}
