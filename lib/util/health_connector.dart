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
      DateTime start, DateTime end, HealthDataType dataType) async {
    await requestAuthorization(dataType);
    final now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day, 0, 0);
    DateTime endDate = DateTime(now.year, now.month, now.day, 23, 59);

    return _healthFactory
        .getHealthDataFromTypes(startDate, endDate, [dataType]);
  }

  Future<bool> requestAuthorization(HealthDataType dataType) {
    return _healthFactory.requestAuthorization([dataType]);
  }
}
