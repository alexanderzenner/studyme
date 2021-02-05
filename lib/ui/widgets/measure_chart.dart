import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import "package:collection/collection.dart";

class MeasureChart extends StatefulWidget {
  final Measure measure;

  MeasureChart({@required this.measure});

  @override
  _MeasureChartState createState() => _MeasureChartState();
}

class _MeasureChartState extends State<MeasureChart> {
  bool _isLoading;

  List<TrialLog> _logs;

  @override
  void initState() {
    _isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadLogs();
  }

  loadLogs() async {
    List<TrialLog> _data =
        await Provider.of<LogData>(context).getLogsFor(widget.measure);
    setState(() {
      _logs = _data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle(widget.measure.name),
      if (_isLoading) CircularProgressIndicator(),
      if (!_isLoading)
        Container(
            height: MediaQuery.of(context).size.height / 4,
            child: _buildChart())
    ]);
  }

  Widget _buildChart() {
    return charts.TimeSeriesChart(_getTimeSeries(),
        animate: false,
        defaultInteractions: false,
        defaultRenderer: charts.PointRendererConfig<DateTime>(radiusPx: 5),
        primaryMeasureAxis: widget.measure.tickProvider);
  }

  List<charts.Series<_ChartValue, DateTime>> _getTimeSeries() {
    return [
      new charts.Series<_ChartValue, DateTime>(
        id: 'measurements',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (_ChartValue value, _) => value.timestamp,
        measureFn: (_ChartValue value, _) => value.value,
        data: _getAggregatedValues(),
      )
    ];
  }

  List<_ChartValue> _getAggregatedValues() {
    final _logsGroupedByDate = groupBy(
        _logs,
        (TrialLog log) =>
            DateTime(log.dateTime.year, log.dateTime.month, log.dateTime.day));

    _logs.forEach((log) => print(log.dateTime));

    return _logsGroupedByDate.entries.map((e) {
      List<num> _values = e.value.map((log) => log.value).toList();
      num _aggregatedValue;

      if (widget.measure.aggregation == Aggregation.Average) {
        _aggregatedValue = _calculateMean(_values);
      } else if (widget.measure.aggregation == Aggregation.Sum) {
        _aggregatedValue = _calculateSum(_values);
      }

      DateTime _datetime = DateTime(e.key.year, e.key.month, e.key.day);
      return _ChartValue(e.key.day, _datetime, _aggregatedValue);
    }).toList();
  }

  _calculateSum(List<num> values) => values.reduce((a, b) => a + b);

  _calculateMean(List<num> values) => _calculateSum(values) / values.length;
}

class _ChartValue {
  num aggregationUnit;
  DateTime timestamp;
  num value;

  _ChartValue(this.aggregationUnit, this.timestamp, this.value);
}
