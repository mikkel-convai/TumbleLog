import 'package:tumblelog/core/entities/club_entity.dart';
import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class AddClubUseCase {
  final AdminRepository repository;

  AddClubUseCase(this.repository);

  Future<Club> execute(String clubName) async {
    return repository.addClub(clubName);
  }
}
