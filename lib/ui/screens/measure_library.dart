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
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                  "What ${(model.trial.measures.length > 0) ? 'other ' : ''}data do you want to collect to assess if you are achieving your goal (${model.trial.outcome})?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'Create your own',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {
                          _createMeasure(context);
                        }),
                    Text('or select existing:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _unaddedMeasures.length,
                  itemBuilder: (context, index) {
                    Measure _measure = _unaddedMeasures[index];
                    return MeasureCard(
                        measure: _measure,
                        onTap: () => _previewMeasure(context, _measure));
                  },
                ),
              ),
            ],
          ),
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
