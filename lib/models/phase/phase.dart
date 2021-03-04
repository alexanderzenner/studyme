import 'package:hive/hive.dart';

abstract class Phase {
  @HiveField(0)
  String name;

  @HiveField(1)
  String letter;

  Phase({this.name, this.letter});
}
