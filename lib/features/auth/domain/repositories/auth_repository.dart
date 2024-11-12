import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';

abstract class AuthRepository {
  Future<Session?> getCurrentSession();
  Future<AppUser?> getCurrentUser(String id);
  Future<void> logOut();
}
