import 'package:equatable/equatable.dart';

class AthleteProgramEntity extends Equatable {
  final String athleteId;
  final String programId;

  const AthleteProgramEntity({
    required this.athleteId,
    required this.programId,
  });

  @override
  List<Object?> get props => [athleteId, programId];
}
