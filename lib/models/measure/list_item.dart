import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class ListItem extends HiveObject {
  @HiveField(0)
  String value;

  ListItem({this.value});

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
  Map<String, dynamic> toJson() => _$ListItemToJson(this);
}
