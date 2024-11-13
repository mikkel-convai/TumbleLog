import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class UpdateUserClubUseCase {
  final AdminRepository repository;

  UpdateUserClubUseCase(this.repository);

  Future<void> execute(String userId, String? newClubId) async {
    return repository.updateUserClub(userId, newClubId);
  }
}
