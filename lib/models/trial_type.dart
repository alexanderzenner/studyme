import 'package:hive/hive.dart';

part 'trial_type.g.dart';

@HiveType(typeId: 205)
enum TrialType {
  @HiveField(0)
  reversal,
  @HiveField(1)
  alternatingTreatment
}
