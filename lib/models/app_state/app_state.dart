import 'package:hive/hive.dart';

part 'app_state.g.dart';

@HiveType(typeId: 10)
enum AppState {
  @HiveField(0)
  ONBOARDING,
  @HiveField(1)
  CREATING_DETAILS,
  @HiveField(2)
  CREATING_PHASES,
  @HiveField(3)
  DOING
}
