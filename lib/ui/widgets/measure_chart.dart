import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_state.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class MeasureChart extends StatefulWidget {
  final Measure measure;

  MeasureChart({@required this.measure});

  @override
  _MeasureChartState createState() => _MeasureChartState();
}

class _MeasureChartState extends State<MeasureChart> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle(widget.measure.name),
      FutureBuilder<List<TrialLog>>(
          future: Provider.of<LogState>(context).getLogsFor(widget.measure),
          builder: (context, AsyncSnapshot<List<TrialLog>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: _buildChart(snapshot.data));
            } else {
              child = CircularProgressIndicator();
            }
            return child;
          }),
    ]);
  }

  Widget _buildChart(List<TrialLog> logs) {
    return charts.TimeSeriesChart(_getTimeSeries(logs),
        animate: false,
        defaultInteractions: false,
        defaultRenderer: charts.PointRendererConfig<DateTime>(radiusPx: 5),
        primaryMeasureAxis: widget.measure.tickProvider);
  }

  List<charts.Series<TrialLog, DateTime>> _getTimeSeries(List<TrialLog> logs) {
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
