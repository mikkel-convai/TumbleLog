import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Session?> getCurrentSession();
  Future<void> logOut();
}
