import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/measure_overview.dart';
import 'package:studyme/ui/widgets/measure_card.dart';

class CreatorMeasureSection extends StatelessWidget {
  final AppData model;

  final bool isActive;

  CreatorMeasureSection(this.model, {this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(
                "Data used to assess if what I am trying out is helping me achieve my goal",
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
                    _previewMeasure(context, index);
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
      ),
    );
  }

  _addMeasure(context) {
    Navigator.pushNamed(context, Routes.measure_library);
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
