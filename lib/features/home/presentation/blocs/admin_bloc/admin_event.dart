part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class FetchClubsAndUsersEvent extends AdminEvent {}

// Events for Clubs
class FetchClubsEvent extends AdminEvent {}

class AddClubEvent extends AdminEvent {
  final String clubName;

  const AddClubEvent(this.clubName);

  @override
  List<Object?> get props => [clubName];
}

class DeleteClubEvent extends AdminEvent {
  final String clubId;

  const DeleteClubEvent(this.clubId);

  @override
  List<Object?> get props => [clubId];
}

// Events for Users
class FetchUsersEvent extends AdminEvent {}

class UpdateUserRoleEvent extends AdminEvent {
  final String userId;
  final String newRole;

  const UpdateUserRoleEvent(this.userId, this.newRole);

  @override
  List<Object?> get props => [userId, newRole];
}

class UpdateUserClubEvent extends AdminEvent {
  final String userId;
  final String? newClubId;

  const UpdateUserClubEvent(this.userId, this.newClubId);

  @override
  List<Object?> get props => [userId, newClubId];
}
