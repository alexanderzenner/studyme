import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choice.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class Choice extends HiveObject {
  @HiveField(0)
  String value;

  Choice({this.value});

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}
