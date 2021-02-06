import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import "package:collection/collection.dart";

class MeasureChart extends StatefulWidget {
  final Measure measure;
  final Trial trial;

  MeasureChart({@required this.measure, @required this.trial});

  @override
  _MeasureChartState createState() => _MeasureChartState();
}

class _MeasureChartState extends State<MeasureChart> {
  bool _isLoading;

  TimeAggregation _timeAggregation;

  List<TrialLog> _logs;

  @override
  void initState() {
    _isLoading = true;
    _timeAggregation = TimeAggregation.Phase;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadLogs();
  }

  loadLogs() async {
    List<TrialLog> _data =
        await Provider.of<LogData>(context).getMeasureLogs(widget.measure);
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

  bool get needSeperators => _timeAggregation == TimeAggregation.Day;

  Widget _buildChart() {
    return charts.NumericComboChart(_getSeriesData(),
        animate: false,
        behaviors: [
          if (needSeperators) _getSeperators(),
        ],
        defaultInteractions: false,
        defaultRenderer: new charts.BarRendererConfig(),
        domainAxis: charts.NumericAxisSpec(
            viewport: _getExtents(),
            tickFormatterSpec: _getFormatterSpec(),
            tickProviderSpec: _getProviderSpec()),
        primaryMeasureAxis: widget.measure.tickProvider);
  }

  charts.RangeAnnotation _getSeperators() => charts.RangeAnnotation(
        Iterable.generate(widget.trial.schedule.numberOfPhases + 1)
            .map((i) => charts.LineAnnotationSegment<num>(
                  i * widget.trial.schedule.phaseDuration - 0.5,
                  charts.RangeAnnotationAxisType.domain,
                  color: charts.MaterialPalette.gray.shade400,
                  strokeWidthPx: 1,
                ))
            .toList(),
      );

  charts.NumericExtents _getExtents() {
    if (_timeAggregation == TimeAggregation.Day) {
      return charts.NumericExtents(
          0,
          widget.trial.schedule.numberOfPhases *
                  widget.trial.schedule.phaseDuration -
              1);
    } else if (_timeAggregation == TimeAggregation.Phase) {
      print(widget.trial.schedule.numberOfPhases);
      return charts.NumericExtents(0, widget.trial.schedule.numberOfPhases - 1);
    } else {
      return null;
    }
  }

  charts.TickFormatterSpec _getFormatterSpec() {
    if (_timeAggregation == TimeAggregation.Day) {
      return charts.BasicNumericTickFormatterSpec(
          (value) => (value + 1).toInt().toString());
    } else {
      return null;
    }
  }

  charts.NumericTickProviderSpec _getProviderSpec() {
    if (_timeAggregation == TimeAggregation.Phase) {
      return charts.StaticNumericTickProviderSpec([
        charts.TickSpec<num>(0),
        charts.TickSpec<num>(1),
        charts.TickSpec<num>(2),
        charts.TickSpec<num>(3),
      ]);
    } else {
      return null;
    }
  }

  List<charts.Series<_ChartValue, num>> _getSeriesData() {
    return [
      charts.Series<_ChartValue, num>(
        id: 'hi',
        colorFn: (_ChartValue value, __) => value.loggedItemId == 'a'
            ? charts.MaterialPalette.blue.shadeDefault
            : charts.MaterialPalette.green.shadeDefault,
        domainFn: (_ChartValue value, _) => value.aggregationUnit,
        measureFn: (_ChartValue value, _) => value.value,
        data: _getAggregatedValues(),
      )
    ];
  }

  List<_ChartValue> _getAggregatedValues() {
    if (_timeAggregation == TimeAggregation.Day) {
      final _logsGroupedByDate = groupBy(
          _logs,
          (TrialLog log) => DateTime(
              log.dateTime.year, log.dateTime.month, log.dateTime.day));
      return _logsGroupedByDate.entries.map((entry) {
        List<num> _values = entry.value.map((log) => log.value).toList();
        num _aggregationUnit = widget.trial.getDayOfStudyFor(entry.key);
        Intervention _intervention =
            widget.trial.getInterventionForDate(entry.key);
        return _ChartValue(
            _aggregationUnit, _aggregate(_values), _intervention.letter);
      }).toList();
    } else if (_timeAggregation == TimeAggregation.Phase) {
      final _logsGroupedByPhase = groupBy(_logs,
          (TrialLog log) => widget.trial.getPhaseIndexForDate(log.dateTime));
      return _logsGroupedByPhase.entries.map((entry) {
        List<num> _values = entry.value.map((log) => log.value).toList();
        Intervention _intervention =
            widget.trial.getInterventionForPhaseIndex(entry.key);
        return _ChartValue(
            entry.key, _aggregate(_values), _intervention.letter);
      }).toList();
    } else {
      return [];
    }
  }

  _aggregate(List<num> values) {
    if (widget.measure.aggregation == Aggregation.Average) {
      return _calculateMean(values);
    } else if (widget.measure.aggregation == Aggregation.Sum) {
      return _calculateSum(values);
    }
  }

  _calculateSum(List<num> values) => values.reduce((a, b) => a + b);

  _calculateMean(List<num> values) => _calculateSum(values) / values.length;
}

class _ChartValue {
  final num aggregationUnit;
  final num value;
  final String loggedItemId;

  _ChartValue(this.aggregationUnit, this.value, this.loggedItemId);
}

enum TimeAggregation { Day, Phase, Intervention }


// keep this in case I need it
/*   charts.StaticNumericTickProviderSpec _getDomainTicks() {
    if (_timeAggregation == TimeAggregation.Day) {
      return charts.StaticNumericTickProviderSpec(widget
          .trial.schedule.phaseSequence
          .asMap()
          .map((index, value) => MapEntry(
              index * widget.trial.schedule.phaseDuration +
                  (widget.trial.schedule.phaseDuration - 1) / 2,
              value))
          .entries
          .map((entry) =>
              charts.TickSpec<num>(entry.key, label: entry.value.toUpperCase()))
          .toList());
    } else {
      return null;
    }
  } */