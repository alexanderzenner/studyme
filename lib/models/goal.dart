import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention.dart';
import 'package:uuid/uuid.dart';

part 'goal.g.dart';

@JsonSerializable()
@HiveType(typeId: 203)
class Goal {
  @HiveField(0)
  String id;

  @HiveField(1)
  String goal;

  @JsonKey(ignore: true)
  List<Intervention> _suggestedInterventions;

  @JsonKey(ignore: true)
  List<Intervention> get suggestedInterventions => _suggestedInterventions;

  Goal({id, this.goal, suggestedInterventions})
      : this.id = id ?? Uuid().v4(),
        this._suggestedInterventions = suggestedInterventions ?? [];

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
