import 'package:supabase_flutter/supabase_flutter.dart';
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
}
