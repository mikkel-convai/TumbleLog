import 'package:tumblelog/core/entities/app_user_entity.dart';

abstract class AthleteRepository {
  Future<List<AppUser>> loadAthletes(String? userClub);
}
