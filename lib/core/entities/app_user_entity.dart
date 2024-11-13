import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? clubId;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.clubId,
  });

  @override
  List<Object?> get props => [id, name, role, email, clubId];
}
