import 'package:equatable/equatable.dart';

class SkillLibraryEntity extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double difficulty;
  final String? creatorId;
  final bool isDefault;

  const SkillLibraryEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.difficulty,
    this.creatorId,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        difficulty,
        isDefault,
        creatorId,
      ];
}
