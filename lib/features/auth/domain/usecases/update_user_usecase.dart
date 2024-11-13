import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';

class UpdateUserUseCase {
  final AuthRepository repository;
  UpdateUserUseCase(this.repository);

  Future<AppUser?> execute({
    required String userId,
    required Map<String, dynamic> updatedFields,
  }) async {
    final AppUser? updatedUser =
        await repository.updateUser(userId, updatedFields);

    return updatedUser;
  }
}
