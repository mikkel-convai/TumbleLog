import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'club_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ClubModel extends Equatable {
  final String id;
  final String name;

  const ClubModel({
    required this.id,
    required this.name,
  });

  // JSON serialization
  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubModelToJson(this);

  @override
  List<Object> get props => [id, name];
}
