import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String id;
  final String athleteName;
  final DateTime date;

  const SessionEntity({
    required this.id,
    required this.athleteName,
    required this.date,
  });

  @override
  List<Object> get props => [id, athleteName, date];
}
