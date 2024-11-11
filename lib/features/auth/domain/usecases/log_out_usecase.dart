import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository repository;
  LogOutUseCase({required this.repository});

  Future<void> execute() async {
    await repository.logOut();
  }
}
