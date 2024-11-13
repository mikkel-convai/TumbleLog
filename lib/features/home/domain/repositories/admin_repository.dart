import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/entities/club_entity.dart';

abstract class AdminRepository {
  Future<List<Club>> fetchClubs();
  Future<Club> addClub(String clubName);
  Future<void> deleteClub(String clubId);
  Future<List<AppUser>> fetchUsers();
  Future<void> updateUserRole(String userId, String newRole);
  Future<void> updateUserClub(String userId, String? newClubId);
}
