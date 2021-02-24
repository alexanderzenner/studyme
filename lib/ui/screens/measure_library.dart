import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/measure_creator_type.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/measure_card.dart';

import 'measure_overview.dart';

class MeasureLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      List<Measure> _unaddedMeasures = model.unaddedMeasures;
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Add Measure"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HintCard(
                titleText: "Add existing or new measure",
                body: [
                  Text(
                      "You can choose from a set of predefined measures or create your own."),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _unaddedMeasures.length,
                itemBuilder: (context, index) {
                  Measure _measure = _unaddedMeasures[index];
                  return MeasureCard(
                      measure: _measure,
                      onTap: () => _previewMeasure(context, _measure));
                },
              ),
              SizedBox(height: 90)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _createMeasure(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  _previewMeasure(context, measure) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MeasureOverview(isPreview: true, measure: measure),
      ),
    );
  }

  _createMeasure(context) {
    Function saveFunction = (Measure measure) {
      Provider.of<AppData>(context, listen: false).addMeasure(measure);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureCreatorType(onSave: saveFunction),
      ),
    );
  }
}
