part of 'auth_bloc.dart';

sealed class AppAuthState extends Equatable {
  const AppAuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AppAuthState {}

final class AuthLoading extends AppAuthState {}

final class AuthUnauthenticated extends AppAuthState {}

final class AuthError extends AppAuthState {
  final String message;

  const AuthError({required this.message});
}

final class AuthAuthenticated extends AppAuthState {
  final String user;
  final Session session;

  const AuthAuthenticated({
    required this.user,
    required this.session,
  });

  @override
  List<Object> get props => [user, session];
}
