import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/entities/club_entity.dart';
import 'package:tumblelog/features/home/domain/usecases/add_club.dart';
import 'package:tumblelog/features/home/domain/usecases/delete_club.dart';
import 'package:tumblelog/features/home/domain/usecases/fetch_clubs.dart';
import 'package:tumblelog/features/home/domain/usecases/fetch_users.dart';
import 'package:tumblelog/features/home/domain/usecases/update_user_club.dart';
import 'package:tumblelog/features/home/domain/usecases/update_user_role.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final FetchClubsUseCase fetchClubsUseCase;
  final AddClubUseCase addClubUseCase;
  final DeleteClubUseCase deleteClubUseCase;
  final FetchUsersUseCase fetchUsersUseCase;
  final UpdateUserRoleUseCase updateUserRoleUseCase;
  final UpdateUserClubUseCase updateUserClubUseCase;

  AdminBloc({
    required this.fetchClubsUseCase,
    required this.addClubUseCase,
    required this.deleteClubUseCase,
    required this.fetchUsersUseCase,
    required this.updateUserRoleUseCase,
    required this.updateUserClubUseCase,
  }) : super(AdminInitial()) {
    on<FetchClubsAndUsersEvent>(_onFetchClubsAndUsers);
    on<FetchClubsEvent>(_onFetchClubs);
    on<AddClubEvent>(_onAddClub);
    on<DeleteClubEvent>(_onDeleteClub);
    on<FetchUsersEvent>(_onFetchUsers);
    on<UpdateUserRoleEvent>(_onUpdateUserRole);
    on<UpdateUserClubEvent>(_onUpdateUserClub);
  }

  Future<void> _onFetchClubsAndUsers(
      FetchClubsAndUsersEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      final clubs = await fetchClubsUseCase.execute();
      final users = await fetchUsersUseCase.execute();

      emit(AdminStateLoaded(clubs, users));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onFetchClubs(
      FetchClubsEvent event, Emitter<AdminState> emit) async {
    final currentState = state;
    emit(AdminLoading());

    try {
      final clubs = await fetchClubsUseCase.execute();

      if (currentState is AdminStateLoaded) {
        emit(AdminStateLoaded(clubs, currentState.users));
      } else {
        emit(AdminStateLoaded(clubs, const []));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onFetchUsers(
      FetchUsersEvent event, Emitter<AdminState> emit) async {
    final currentState = state;
    emit(AdminLoading());

    try {
      final users = await fetchUsersUseCase.execute();

      if (currentState is AdminStateLoaded) {
        emit(AdminStateLoaded(currentState.clubs, users));
      } else {
        emit(AdminStateLoaded(const [], users));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onAddClub(AddClubEvent event, Emitter<AdminState> emit) async {
    final currentState = state;
    emit(AdminLoading());

    try {
      final newClub = await addClubUseCase.execute(event.clubName);

      if (currentState is AdminStateLoaded) {
        emit(AdminStateLoaded(
            List.from(currentState.clubs)..add(newClub), currentState.users));
      } else {
        emit(AdminStateLoaded([newClub], const []));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onDeleteClub(
      DeleteClubEvent event, Emitter<AdminState> emit) async {
    final currentState = state;
    emit(AdminLoading());

    try {
      await deleteClubUseCase.execute(event.clubId);
      final updatedUsers = await fetchUsersUseCase.execute();

      if (currentState is AdminStateLoaded) {
        emit(AdminStateLoaded(
            List.from(currentState.clubs)
              ..removeWhere((club) => club.id == event.clubId),
            updatedUsers));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onUpdateUserRole(
      UpdateUserRoleEvent event, Emitter<AdminState> emit) async {
    final currentState = state;

    try {
      await updateUserRoleUseCase.execute(event.userId, event.newRole);

      if (currentState is AdminStateLoaded) {
        final updatedUsers = currentState.users.map((user) {
          if (user.id == event.userId) {
            return AppUser(
              id: user.id,
              name: user.name,
              email: user.email,
              role: event.newRole,
              clubId: user.clubId,
            );
          }
          return user;
        }).toList();
        emit(AdminStateLoaded(currentState.clubs, updatedUsers));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onUpdateUserClub(
      UpdateUserClubEvent event, Emitter<AdminState> emit) async {
    final currentState = state;

    try {
      await updateUserClubUseCase.execute(event.userId, event.newClubId);

      if (currentState is AdminStateLoaded) {
        final updatedUsers = currentState.users.map((user) {
          if (user.id == event.userId) {
            return AppUser(
              id: user.id,
              name: user.name,
              email: user.email,
              role: user.role,
              clubId: event.newClubId,
            );
          }
          return user;
        }).toList();
        emit(AdminStateLoaded(currentState.clubs, updatedUsers));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
