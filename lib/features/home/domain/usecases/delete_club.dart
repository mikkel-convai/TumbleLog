import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class DeleteClubUseCase {
  final AdminRepository repository;

  DeleteClubUseCase(this.repository);

  Future<void> execute(String clubId) async {
    return repository.deleteClub(clubId);
  }
}
