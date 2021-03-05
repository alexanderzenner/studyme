import 'package:hive/hive.dart';
import 'package:studyme/util/string_extension.dart';

part 'aggregations.g.dart';

@HiveType(typeId: 6)
enum ValueAggregation {
  @HiveField(0)
  Average,
  @HiveField(1)
  Sum
}

extension AggregationExtension on ValueAggregation {
  String get readable => this.toString().split('.').last.capitalize();
}

enum TimeAggregation { Day, Phases, Phase }

extension TimeAggregationExtension on TimeAggregation {
  String get readable => this.toString().split('.').last.capitalize();
}
