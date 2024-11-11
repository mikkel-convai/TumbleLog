import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentSessionUseCase {
  final AuthRepository repository;
  GetCurrentSessionUseCase({required this.repository});

  Future<Session?> execute() async {
    return await repository.getCurrentSession();
  }
}
