import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention.dart';
import 'package:uuid/uuid.dart';

part 'outcome.g.dart';

@JsonSerializable()
@HiveType(typeId: 203)
class Outcome {
  @HiveField(0)
  String id;

  @HiveField(1)
  String outcome;

  @JsonKey(ignore: true)
  List<Intervention> _suggestedInterventions;

  @JsonKey(ignore: true)
  List<Intervention> get suggestedInterventions => _suggestedInterventions;

  Outcome({id, this.outcome, suggestedInterventions})
      : this.id = id ?? Uuid().v4(),
        this._suggestedInterventions = suggestedInterventions ?? [];

  factory Outcome.fromJson(Map<String, dynamic> json) =>
      _$OutcomeFromJson(json);
  Map<String, dynamic> toJson() => _$OutcomeToJson(this);
}
