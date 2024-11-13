import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppUserModel extends Equatable {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? clubId;

  const AppUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.clubId,
  });

  /// Factory constructor for creating a new `AppUserModel` instance from a map.
  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  /// Converts this `AppUserModel` instance to a map.
  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);

  @override
  List<Object?> get props => [id, name, role, email, clubId];
}
