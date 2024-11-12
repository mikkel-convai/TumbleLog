import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;
  GetCurrentUserUseCase({required this.repository});

  Future<AppUser?> execute(String id) async {
    return await repository.getCurrentUser(id);
  }
}
