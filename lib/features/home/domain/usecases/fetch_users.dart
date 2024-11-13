import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class FetchUsersUseCase {
  final AdminRepository repository;

  FetchUsersUseCase(this.repository);

  Future<List<AppUser>> execute() async {
    return repository.fetchUsers();
  }
}
