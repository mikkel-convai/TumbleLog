import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String id;
  final String athleteId;
  final String athleteName;
  final DateTime date;

  const SessionEntity({
    required this.id,
    required this.athleteId,
    required this.date,
    this.athleteName = 'Grisha',
  });

  @override
  List<Object?> get props => [id, athleteId, athleteName, date];
}
