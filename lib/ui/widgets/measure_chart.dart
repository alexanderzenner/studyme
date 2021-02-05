import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
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

  List<charts.Series<TrialLog, DateTime>> _getTimeSeries() {
    return [
      new charts.Series<TrialLog, DateTime>(
        id: 'measurements',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TrialLog log, _) => log.dateTime,
        measureFn: (TrialLog log, _) => log.value,
        data: _logs,
      )
    ];
  }
}
