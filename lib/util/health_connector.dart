import "package:collection/collection.dart";
import 'package:health/health.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/automatic_measure.dart';
import 'package:studyme/models/trial.dart';

class HealthConnector {
  static HealthConnector _instance;
  HealthFactory _healthFactory;

  HealthConnector._internal() {
    _healthFactory = HealthFactory();
  }

  factory HealthConnector() {
    if (_instance == null) {
      _instance = HealthConnector._internal();
    }
    return _instance;
  }

  Future<List<HealthDataPoint>> fetchValuesFor(
      DateTime start, DateTime end, List<HealthDataType> dataTypes) async {
    await requestAuthorization(dataTypes);
    return _healthFactory.getHealthDataFromTypes(start, end, dataTypes);
  }

  Future<bool> requestAuthorization(List<HealthDataType> dataTypes) {
    return _healthFactory.requestAuthorization(dataTypes);
  }

  syncMeasures(Trial trial, Function saveCallback) async {
    List<AutomaticMeasure> _measures = trial.syncedMeasures;

    if (_measures.length > 0) {
      Map<HealthDataType, AutomaticMeasure> dataTypeToMeasureMap = {};

      _measures.forEach((AutomaticMeasure measure) {
        dataTypeToMeasureMap.putIfAbsent(
            measure.trackedHealthDataType, () => measure);
      });

      List<HealthDataPoint> dataPoints = await HealthConnector().fetchValuesFor(
          trial.startDate, trial.endDate, dataTypeToMeasureMap.keys.toList());
      dataPoints
          .removeWhere((element) => element.dateTo.isAfter(DateTime.now()));
      groupBy(dataPoints, (HealthDataPoint point) => point.type)
          .forEach((dataType, healthPoints) {
        AutomaticMeasure _measure = dataTypeToMeasureMap[dataType];
        List<TrialLog> _measureLogs = healthPoints
            .map((_point) => _measure.createLogFrom(_point))
            .toList();
        saveCallback(_measureLogs, _measure);
      });
    }
  }
}
