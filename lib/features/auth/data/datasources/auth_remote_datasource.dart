import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/app_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Session?> getCurrentSession();
  Future<AppUserModel?> getCurrentUser(String id);
  Future<AppUserModel?> updateUser(
      String userId, Map<String, dynamic> updatedFields);
  Future<void> logOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<Session?> getCurrentSession() async {
    try {
      final session = supabaseClient.auth.currentSession;
      return session;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    supabaseClient.auth.signOut();
  }

  @override
  Future<AppUserModel?> getCurrentUser(String id) async {
    try {
      final userJson =
          await supabaseClient.from('users').select().eq('id', id).single();
      final AppUserModel user = AppUserModel.fromJson(userJson);
      return user;
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  Future<AppUserModel?> updateUser(
      String userId, Map<String, dynamic> updatedFields) async {
    try {
      final userJson = await supabaseClient
          .from('users')
          .update(updatedFields)
          .eq('id', userId)
          .select();

      if (userJson.isNotEmpty) {
        final AppUserModel user = AppUserModel.fromJson(userJson.first);
        return user;
      }

      print('AuthRemoteDataSource: User update returned nothing');
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
