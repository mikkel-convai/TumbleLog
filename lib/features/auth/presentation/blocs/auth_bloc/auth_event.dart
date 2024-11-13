part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class CheckAuthStatus extends AuthEvent {}

final class AuthUpdateUserDetails extends AuthEvent {
  final String userId;
  final Map<String, dynamic> updatedFields;

  const AuthUpdateUserDetails({
    required this.userId,
    required this.updatedFields,
  });

  @override
  List<Object> get props => [userId, updatedFields];
}

final class LogIn extends AuthEvent {
  final String email;
  final String password;

  const LogIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogOut extends AuthEvent {}
