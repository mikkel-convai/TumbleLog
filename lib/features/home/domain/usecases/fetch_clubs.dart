import 'package:tumblelog/core/entities/club_entity.dart';
import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';

class FetchClubsUseCase {
  final AdminRepository repository;

  FetchClubsUseCase(this.repository);

  Future<List<Club>> execute() async {
    return repository.fetchClubs();
  }
}
