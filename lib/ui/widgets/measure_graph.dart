import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_state.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MeasureGraph extends StatefulWidget {
  final Measure measure;

  MeasureGraph({@required this.measure});

  @override
  _MeasureGraphState createState() => _MeasureGraphState();
}

class _MeasureGraphState extends State<MeasureGraph> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.measure.name, style: TextStyle(fontWeight: FontWeight.bold)),
      FutureBuilder<List<TrialLog>>(
          future: Provider.of<LogState>(context).getLogsFor(widget.measure),
          builder: (context, AsyncSnapshot<List<TrialLog>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = _createGraph(snapshot.data);
            } else {
              child = CircularProgressIndicator();
            }
            return child;
          }),
    ]);
  }

  Widget _createGraph(List<TrialLog> logs) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: charts.TimeSeriesChart(_createSampleData(logs),
          animate: false,
          defaultRenderer: new charts.BarRendererConfig<DateTime>(),
          defaultInteractions: false,
          primaryMeasureAxis: widget.measure.tickProvider),
    );
  }

  List<charts.Series<TrialLog, DateTime>> _createSampleData(
      List<TrialLog> logs) {
    return [
      new charts.Series<TrialLog, DateTime>(
        id: 'measurements',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TrialLog log, _) => log.dateTime,
        measureFn: (TrialLog log, _) => log.value,
        data: logs,
      )
    ];
  }
}
