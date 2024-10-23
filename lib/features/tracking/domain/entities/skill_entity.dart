// import 'package:equatable/equatable.dart';

// class SkillEntity extends Equatable {
//   final String id;
//   final String name;
//   final String symbol;
//   final String equipment;
//   final int reps;

//   const SkillEntity({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.equipment,
//     required this.reps,
//   });

//   @override
//   List<Object> get props => [id, name, symbol, equipment, reps];
// }

class SkillEntity {
  final String name;
  final DateTime date;
  final String symbol;
  final double difficulty;
  final String equipment;
  int reps;

  SkillEntity({
    required this.name,
    required this.symbol,
    this.difficulty = 0.0,
    DateTime? date,
    this.equipment = 'rod floor',
    this.reps = 0,
  }) : date = date ?? DateTime.now();
}
