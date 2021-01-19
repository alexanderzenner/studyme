import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/log_state.dart';
import 'package:studyme/models/log/log.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, trialState, child) {
      return Consumer<LogState>(builder: (context, logState, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              OutlineButton(
                child: Text('change'),
                onPressed: () {
                  print('HI');
                },
              ),
              Expanded(
                child: charts.TimeSeriesChart(_createSampleData(logState),
                    animate: false,
                    defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                    defaultInteractions: false,
                    primaryMeasureAxis:
                        trialState.trial.measures[0].tickProvider),
              ),
            ],
          ),
        );
      });
    });
  }

  static List<charts.Series<TrialLog, DateTime>> _createSampleData(logState) {
    return [
      new charts.Series<TrialLog, DateTime>(
        id: 'measurements',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TrialLog log, _) => log.dateTime,
        measureFn: (TrialLog log, _) => log.value,
        data: logState.getLogs(),
      )
    ];
  }
}
