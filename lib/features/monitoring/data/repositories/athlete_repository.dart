import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/models/app_user_model.dart';
import 'package:tumblelog/features/monitoring/data/datasources/athlete_remote_datasource.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/athlete_repository.dart';

class AthleteRepositoryImpl implements AthleteRepository {
  final AthleteRemoteDataSource remoteDataSource;

  const AthleteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AppUser>> loadAthletes(String? userClub) async {
    final List<AppUserModel> userModels =
        await remoteDataSource.loadAthletes(userClub);
    final List<AppUser> users = userModels
        .map((model) => AppUser(
              id: model.id,
              name: model.name,
              email: model.email,
              role: model.role,
            ))
        .toList();

    return users;
  }
}
