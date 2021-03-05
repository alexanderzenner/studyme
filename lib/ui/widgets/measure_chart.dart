import 'package:charts_flutter/flutter.dart' as charts;
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/aggregations.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/trial.dart';

class MeasureChart extends StatefulWidget {
  final Measure measure;
  final Trial trial;
  final TimeAggregation timeAggregation;

  MeasureChart(
      {@required this.measure,
      @required this.trial,
      @required this.timeAggregation});

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
        await Provider.of<LogData>(context).getMeasureLogs(widget.measure);
    _data.removeWhere((log) => !widget.trial.isInStudyTimeframe(log.dateTime));
    setState(() {
      _logs = _data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('${widget.measure.name} (${widget.measure.aggregation.readable})',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor)),
      if (_isLoading) CircularProgressIndicator(),
      if (!_isLoading)
        Container(height: _getContainerHeight(), child: _buildChart())
    ]);
  }

  double _getContainerHeight() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.height / 2;
    } else {
      return MediaQuery.of(context).size.height / 4;
    }
  }

  Widget _buildChart() {
    final _seperators = _getSeperators();
    return charts.NumericComboChart(_getSeriesData(),
        animate: false,
        behaviors: [
          if (_seperators != null) (() => _seperators)(),
          charts.ChartTitle(
            widget.timeAggregation.readable,
            outerPadding: 0,
            innerPadding: 2,
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 15),
          ),
        ],
        defaultInteractions: false,
        defaultRenderer: new charts.BarRendererConfig(),
        customSeriesRenderers: [
          new charts.PointRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'bar')
        ],
        domainAxis: charts.NumericAxisSpec(
            viewport: _getExtents(),
            tickFormatterSpec: _getFormatterSpec(),
            tickProviderSpec: _getProviderSpec()),
        primaryMeasureAxis: widget.measure.tickProvider);
  }

  charts.RangeAnnotation _getSeperators() {
    if (widget.timeAggregation == TimeAggregation.Day) {
      return charts.RangeAnnotation(
        Iterable.generate(widget.trial.schedule.numberOfPhases + 1)
            .map((i) => charts.LineAnnotationSegment<num>(
                  i * widget.trial.schedule.phaseDuration - 0.5,
                  charts.RangeAnnotationAxisType.domain,
                  color: charts.MaterialPalette.gray.shade400,
                  strokeWidthPx: 1,
                ))
            .toList(),
      );
    } else {
      return charts.RangeAnnotation([]);
    }
  }

  charts.NumericExtents _getExtents() {
    if (widget.timeAggregation == TimeAggregation.Day) {
      return charts.NumericExtents(
          0,
          widget.trial.schedule.numberOfPhases *
                  widget.trial.schedule.phaseDuration -
              1);
    } else if (widget.timeAggregation == TimeAggregation.Phases) {
      return charts.NumericExtents(0, widget.trial.schedule.numberOfPhases - 1);
    } else if (widget.timeAggregation == TimeAggregation.Phase) {
      return charts.NumericExtents(0, 1);
    } else {
      return null;
    }
  }

  charts.TickFormatterSpec _getFormatterSpec() {
    if (widget.timeAggregation == TimeAggregation.Day) {
      return charts.BasicNumericTickFormatterSpec(
          (value) => (value + 1).toInt().toString());
    } else if (widget.timeAggregation == TimeAggregation.Phases) {
      return charts.BasicNumericTickFormatterSpec((value) =>
          "${(value + 1).toString()} (${widget.trial.schedule.phaseSequence[value].toUpperCase()})");
    } else if (widget.timeAggregation == TimeAggregation.Phase) {
      return charts.BasicNumericTickFormatterSpec((value) {
        if (value == 0) return 'A';
        if (value == 1)
          return 'B';
        else
          return null;
      });
    } else {
      return null;
    }
  }

  charts.NumericTickProviderSpec _getProviderSpec() {
    if (widget.timeAggregation == TimeAggregation.Phases) {
      return charts.StaticNumericTickProviderSpec(
          Iterable.generate(widget.trial.schedule.numberOfPhases)
              .map((e) => charts.TickSpec<num>(e))
              .toList());
    } else if (widget.timeAggregation == TimeAggregation.Phase) {
      return charts.StaticNumericTickProviderSpec(
          [charts.TickSpec<num>(0), charts.TickSpec<num>(1)]);
    } else {
      return null;
    }
  }

  List<charts.Series<_ChartValue, num>> _getSeriesData() {
    return [
      new charts.Series<_ChartValue, num>(
        id: 'bar',
        colorFn: (_ChartValue value, __) => value.color,
        domainFn: (_ChartValue value, _) => value.aggregationUnit,
        measureFn: (_ChartValue value, _) => value.value,
        data: _getAggregatedValues(),
      ),
      new charts.Series<_ChartValue, num>(
        id: 'point',
        colorFn: (_ChartValue value, __) => value.color,
        domainFn: (_ChartValue value, _) => value.aggregationUnit,
        measureFn: (_ChartValue value, _) => value.value,
        data: _getAggregatedValues(),
      )..setAttribute(charts.rendererIdKey, 'bar'),
    ];
  }

  List<_ChartValue> _getAggregatedValues() {
    if (widget.timeAggregation == TimeAggregation.Day) {
      final _logsGroupedByDate = groupBy(
          _logs,
          (TrialLog log) => DateTime(
              log.dateTime.year, log.dateTime.month, log.dateTime.day));
      return _logsGroupedByDate.entries.map((entry) {
        num _aggregationUnit = widget.trial.getDayOfStudyFor(entry.key);
        Phase _phase = widget.trial.getPhaseForDate(entry.key);
        return _ChartValue(_aggregationUnit,
            _aggregate(_getValuesFromLogs(entry.value)), _phase.letter);
      }).toList();
    } else if (widget.timeAggregation == TimeAggregation.Phases) {
      final _logsGroupedByPhase = groupBy(_logs,
          (TrialLog log) => widget.trial.getPhaseIndexForDate(log.dateTime));
      return _logsGroupedByPhase.entries.map((entry) {
        Phase _phase = widget.trial.getPhaseForPhaseIndex(entry.key);
        return _ChartValue(entry.key,
            _aggregate(_getValuesFromLogs(entry.value)), _phase.letter);
      }).toList();
    } else if (widget.timeAggregation == TimeAggregation.Phase) {
      final _logsGroupedByIntervention = groupBy(
          _logs, (TrialLog log) => widget.trial.getPhaseForDate(log.dateTime));
      return _logsGroupedByIntervention.entries.map((entry) {
        int aggregationUnit;
        if (entry.key.letter == 'a') {
          aggregationUnit = 0;
        } else {
          aggregationUnit = 1;
        }
        return _ChartValue(aggregationUnit,
            _aggregate(_getValuesFromLogs(entry.value)), entry.key.letter);
      }).toList();
    } else {
      return [];
    }
  }

  List<num> _getValuesFromLogs(List<TrialLog> logs) {
    return logs.map((log) => log.value).toList();
  }

  _aggregate(List<num> values) {
    if (widget.measure.aggregation == ValueAggregation.Average) {
      return _calculateMean(values);
    } else if (widget.measure.aggregation == ValueAggregation.Sum) {
      return _calculateSum(values);
    }
  }

  _calculateSum(List<num> values) => values.reduce((a, b) => a + b);

  _calculateMean(List<num> values) => _calculateSum(values) / values.length;
}

class _ChartValue {
  final dynamic aggregationUnit;
  final num value;
  final String loggedItemId;
  charts.Color color;

  _ChartValue(this.aggregationUnit, this.value, this.loggedItemId) {
    this.color = this.loggedItemId == 'a'
        ? charts.MaterialPalette.blue.shadeDefault
        : charts.MaterialPalette.green.shadeDefault;
  }
}


// keep this in case I need it
/*   charts.StaticNumericTickProviderSpec _getDomainTicks() {
    if (widget.timeAggregation == TimeAggregation.Day) {
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