import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/measure.dart';

part 'free_measure.g.dart';

@HiveType(typeId: 1)
class FreeMeasure extends Measure {
  static const String measureType = 'free';
  final IconData icon = Icons.dialpad;

  FreeMeasure({id, name, description, aggregation})
      : super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation);

  FreeMeasure.clone(FreeMeasure measure) : super.clone(measure);
}
