import 'package:hive/hive.dart';

part 'phase_order.g.dart';

@HiveType(typeId: 202)
enum PhaseOrder {
  @HiveField(0)
  alternating,
  @HiveField(1)
  counterbalanced
}

extension PhaseOrderExtension on PhaseOrder {
  String get humanReadable {
    switch (this) {
      case PhaseOrder.alternating:
        return 'Alternating';
      case PhaseOrder.counterbalanced:
        return 'Counterbalanced';
      default:
        return '';
    }
  }
}
