import 'package:hive/hive.dart';

part 'choice.g.dart';

@HiveType(typeId: 4)
class Choice extends HiveObject {
  @HiveField(0)
  String value;

  Choice({this.value});
}
