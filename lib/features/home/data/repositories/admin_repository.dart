import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/entities/club_entity.dart';
import 'package:tumblelog/features/home/data/datasources/admin_remote_datasource.dart';
import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Club>> fetchClubs() async {
    final models = await remoteDataSource.fetchClubs();
    return models
        .map((model) => Club(
              id: model.id,
              name: model.name,
            ))
        .toList();
  }

  @override
  Future<List<AppUser>> fetchUsers() async {
    final models = await remoteDataSource.fetchUsers();

    return models
        .map((model) => AppUser(
              id: model.id,
              name: model.name,
              email: model.email,
              role: model.role,
              clubId: model.clubId,
            ))
        .toList();
  }

  @override
  Future<Club> addClub(String clubName) async {
    final model = await remoteDataSource.addClub(clubName);
    return Club(
      id: model.id,
      name: model.name,
    );
  }

  @override
  Future<void> deleteClub(String clubId) async {
    await remoteDataSource.deleteClub(clubId);
  }

  @override
  Future<AppUser> updateUserRole(String userId, String newRole) async {
    final model = await remoteDataSource.updateUserRole(userId, newRole);
    return AppUser(
      id: model.id,
      name: model.name,
      email: model.email,
      role: model.role,
      clubId: model.clubId,
    );
  }

  @override
  Future<AppUser> updateUserClub(String userId, String newClubId) async {
    final model = await remoteDataSource.updateUserClub(userId, newClubId);
    return AppUser(
      id: model.id,
      name: model.name,
      email: model.email,
      role: model.role,
      clubId: model.clubId,
    );
  }
}
