import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/measure_log.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/util/health_connector.dart';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    _initAppState();
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  _initAppState() async {
    // first make sure app data is fetched from box
    await Provider.of<AppData>(context, listen: false).loadAppState();
    AppData appData = Provider.of<AppData>(context, listen: false);
    AppState state = appData.state;
    if (state == AppState.ONBOARDING) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    } else if (state == AppState.CREATING) {
      Navigator.pushReplacementNamed(context, Routes.creator);
    } else if (state == AppState.DOING) {
      await _syncMeasures(appData.trial);
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    }
  }

  _syncMeasures(Trial trial) async {
    Map<HealthDataType, SyncedMeasure> dataTypeToMeasureMap = {};

    trial.syncedMeasures.forEach((SyncedMeasure measure) {
      dataTypeToMeasureMap.putIfAbsent(
          measure.trackedHealthDataType, () => measure);
    });

    List<HealthDataPoint> dataPoints = await HealthConnector().fetchValuesFor(
        trial.startDate, trial.endDate, dataTypeToMeasureMap.keys.toList());
    groupBy(dataPoints, (HealthDataPoint point) => point.type)
        .forEach((dataType, healthPoints) {
      SyncedMeasure _measure = dataTypeToMeasureMap[dataType];
      List<MeasureLog> _measureLogs =
          healthPoints.map((_point) => _measure.createLogFrom(_point)).toList();
      Provider.of<LogData>(context, listen: false)
          .checkForDuplicatesAndAdd(_measureLogs, _measure);
    });
  }
}
