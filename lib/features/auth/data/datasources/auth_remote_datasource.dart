import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<Session?> getCurrentSession();
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
}
