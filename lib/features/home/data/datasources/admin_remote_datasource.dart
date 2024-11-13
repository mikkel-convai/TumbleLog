import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/club_model.dart';
import 'package:tumblelog/core/models/app_user_model.dart';

abstract class AdminRemoteDataSource {
  Future<List<ClubModel>> fetchClubs();
  Future<List<AppUserModel>> fetchUsers();
  Future<ClubModel> addClub(String clubName);
  Future<void> deleteClub(String clubId);
  Future<AppUserModel> updateUserRole(String userId, String newRole);
  Future<AppUserModel> updateUserClub(String userId, String? newClubId);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final SupabaseClient supabaseClient;

  AdminRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<ClubModel>> fetchClubs() async {
    try {
      final clubsJson = await supabaseClient.from('clubs').select();

      if (clubsJson.isEmpty) {
        return [];
      }

      return (clubsJson as List)
          .map((club) => ClubModel.fromJson(club))
          .toList();
    } catch (e) {
      throw Exception('Error fetching clubs: $e');
    }
  }

  @override
  Future<List<AppUserModel>> fetchUsers() async {
    try {
      final usersJson =
          await supabaseClient.from('users').select().neq('role', 'admin');

      if (usersJson.isEmpty) {
        return [];
      }

      return (usersJson as List)
          .map((user) => AppUserModel.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  @override
  Future<ClubModel> addClub(String clubName) async {
    try {
      final clubJson = await supabaseClient.from('clubs').insert({
        'name': clubName,
      }).select();

      if (clubJson.isEmpty) {
        throw Exception('Error adding club');
      }

      return ClubModel.fromJson(clubJson.first);
    } catch (e) {
      throw Exception('Error adding club: $e');
    }
  }

  @override
  Future<void> deleteClub(String clubId) async {
    try {
      await supabaseClient.from('clubs').delete().eq('id', clubId);
    } catch (e) {
      throw Exception('Error deleting club: $e');
    }
  }

  @override
  Future<AppUserModel> updateUserRole(String userId, String newRole) async {
    try {
      final userJson = await supabaseClient
          .from('users')
          .update({
            'role': newRole,
          })
          .eq('id', userId)
          .select();

      if (userJson.isEmpty) {
        throw Exception('Error updating user role');
      }

      return AppUserModel.fromJson(userJson.first);
    } catch (e) {
      throw Exception('Error updating user role: $e');
    }
  }

  @override
  Future<AppUserModel> updateUserClub(String userId, String? newClubId) async {
    try {
      final userJson = await supabaseClient
          .from('users')
          .update({
            'club_id': newClubId,
          })
          .eq('id', userId)
          .select();

      if (userJson.isEmpty) {
        throw Exception('Error updating user club');
      }

      return AppUserModel.fromJson(userJson.first);
    } catch (e) {
      throw Exception('Error updating user club: $e');
    }
  }
}
