import 'package:hive/hive.dart';
import 'package:studyme/util/string_extension.dart';

part 'phase_order.g.dart';

@HiveType(typeId: 202)
enum PhaseOrder {
  @HiveField(0)
  alternating,
  @HiveField(1)
  counterbalanced
}

extension PhaseOrderExtension on PhaseOrder {
  String get readable => this.toString().split('.').last.capitalize();
}
