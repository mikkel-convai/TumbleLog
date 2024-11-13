import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/models/app_user_model.dart';
import 'package:tumblelog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Session?> getCurrentSession() async {
    return await remoteDataSource.getCurrentSession();
  }

  @override
  Future<void> logOut() async {
    await remoteDataSource.logOut();
  }

  @override
  Future<AppUser?> getCurrentUser(String id) async {
    final AppUserModel? userModel = await remoteDataSource.getCurrentUser(id);
    if (userModel != null) {
      final AppUser user = AppUser(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        role: userModel.role,
        clubId: userModel.clubId,
      );
      return user;
    }
    return null;
  }
}
