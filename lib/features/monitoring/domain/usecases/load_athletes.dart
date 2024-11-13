import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/athlete_repository.dart';

class LoadAthletesUseCase {
  final AthleteRepository repository;

  LoadAthletesUseCase({required this.repository});

  Future<List<AppUser>> execute(String? userClub) async {
    return await repository.loadAthletes(userClub);
  }
}
