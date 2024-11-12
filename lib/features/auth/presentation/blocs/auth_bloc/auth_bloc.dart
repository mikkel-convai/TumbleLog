import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/log_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AppAuthState> {
  final GetCurrentSessionUseCase getCurrentSession;
  final GetCurrentUserUseCase getCurrentUser;
  final LogOutUseCase logOut;

  AuthBloc({
    required this.getCurrentSession,
    required this.getCurrentUser,
    required this.logOut,
  }) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AppAuthState> emit) async {
    emit(AuthLoading());

    try {
      final session = await getCurrentSession.execute();

      if (session != null) {
        final user = await getCurrentUser.execute(session.user.id);
        if (user != null) {
          emit(AuthAuthenticated(user: user, session: session));
        } else {
          emit(const AuthError(message: 'User not available'));
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter<AppAuthState> emit) async {
    emit(AuthLoading());

    try {
      await logOut.execute();

      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
