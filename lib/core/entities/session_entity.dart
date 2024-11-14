import 'package:equatable/equatable.dart';
import 'package:tumblelog/constants.dart';

class SessionEntity extends Equatable {
  final String id;
  final String athleteId;
  final String athleteName;
  final DateTime date;
  final double totalDd;
  final Map<EquipmentType, double> equipmentDd;

  const SessionEntity({
    required this.id,
    required this.athleteId,
    required this.date,
    this.totalDd = 0,
    this.athleteName = 'NoName',
    this.equipmentDd = defaultEquipmentDd,
  });

  @override
  List<Object?> get props => [
        id,
        athleteId,
        athleteName,
        totalDd,
        date,
        equipmentDd,
      ];
}
