import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class UpdateUserRoleUseCase {
  final AdminRepository repository;

  UpdateUserRoleUseCase(this.repository);

  Future<void> execute(String userId, String newRole) async {
    return repository.updateUserRole(userId, newRole);
  }
}
