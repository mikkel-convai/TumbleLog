part of 'admin_bloc.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

// Loading State
class AdminLoading extends AdminState {}

// Success States
class AdminStateLoaded extends AdminState {
  final List<Club> clubs;
  final List<AppUser> users;

  const AdminStateLoaded(this.clubs, this.users);

  @override
  List<Object> get props => [clubs, users];
}

// Error State
class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object> get props => [message];
}
