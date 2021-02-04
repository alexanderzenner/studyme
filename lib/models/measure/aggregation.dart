import 'package:hive/hive.dart';

part 'aggregation.g.dart';

@HiveType(typeId: 6)
enum Aggregation {
  @HiveField(0)
  Average,
  @HiveField(1)
  Sum
}
