import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/log/log.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, model, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            OutlineButton(
              child: Text('change'),
              onPressed: () {
                print('HI');
                print(model.logs.map((e) => e.dateTime));
              },
            ),
            Expanded(
              child: charts.TimeSeriesChart(_createSampleData(model),
                  animate: false,
                  defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                  defaultInteractions: false,
                  primaryMeasureAxis: model.trial.measures[0].tickProvider),
            ),
          ],
        ),
      );
    });
  }

  static List<charts.Series<TrialLog, DateTime>> _createSampleData(model) {
    return [
      new charts.Series<TrialLog, DateTime>(
        id: 'measurements',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TrialLog log, _) => log.dateTime,
        measureFn: (TrialLog log, _) => log.value,
        data: model.logs,
      )
    ];
  }
}
