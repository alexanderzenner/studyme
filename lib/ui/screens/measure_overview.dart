import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/measure_creator_choice.dart';
import 'package:studyme/ui/screens/measure_creator_name.dart';

import 'creator_schedule.dart';

class MeasureOverview extends StatelessWidget {
  final int index;
  const MeasureOverview({@required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(brightness: Brightness.dark, title: Text("Measure")),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<AppData>(builder: (context, model, child) {
                Measure measure = model.trial.measures.length > 0
                    ? model.trial.measures[index]
                    : null;
                if (measure != null) {
                  return Column(
                    children: [
                      ListTile(
                          title: Text("Name"),
                          subtitle: Text(measure.name),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => _editName(context, measure)),
                      ListTile(
                          title: Text("Schedule"),
                          subtitle: Text(measure.schedule.readable),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => _editSchedule(context, measure)),
                      if (measure is ChoiceMeasure)
                        ListTile(
                            title: Text("Choices"),
                            subtitle: Text(measure.choicesString),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => _editChoices(context, measure)),
                      ButtonBar(
                        children: [
                          OutlineButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text("Remove"),
                              onPressed: () => _removeMeasure(context)),
                        ],
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [],
                  );
                }
              })),
        ));
  }

  _removeMeasure(BuildContext context) {
    Provider.of<AppData>(context, listen: false).removeMeasure(index);
    Navigator.pop(context);
  }

  _editName(BuildContext context, Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureCreatorName(
              title: "Measure",
              measure: measure.clone(),
              onSave: _getSaveFunction(context),
              save: true),
        ));
  }

  _editSchedule(BuildContext context, Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatorSchedule(
            title: "Measure",
            objectWithSchedule: measure,
            onSave: _getSaveFunction(context),
          ),
        ));
  }

  _editChoices(BuildContext context, ChoiceMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureCreatorChoice(
              title: "Measure",
              measure: measure.clone(),
              onSave: _getSaveFunction(context),
              save: true),
        ));
  }

  _getSaveFunction(context) {
    return (Measure _measure) {
      Provider.of<AppData>(context).updateMeasure(index, _measure);
      Navigator.pop(context);
    };
  }
}
