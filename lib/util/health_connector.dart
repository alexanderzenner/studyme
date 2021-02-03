import 'package:health/health.dart';

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
}
