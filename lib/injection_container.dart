import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tumblelog/features/auth/data/repositories/auth_repository.dart';
import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/monitoring/data/datasources/skill_remote_datasource.dart';
import 'package:tumblelog/features/monitoring/data/repositories/skill_repository.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/skill_repository.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart';
import 'package:tumblelog/features/tracking/data/repositories/session_repository_impl.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';
import 'package:tumblelog/features/tracking/domain/usecases/calculate_dd_usecase.dart';
import 'package:tumblelog/features/tracking/domain/usecases/save_session_usecase.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';

final getIt = GetIt.instance;
final supabaseClient = Supabase.instance.client;

void setupLocator() async {
  // Register the data sources
  getIt.registerLazySingleton<SessionRemoteDataSource>(
    () => SessionRemoteDataSourceImpl(supabaseClient),
  );
  getIt.registerLazySingleton<SkillRemoteDataSource>(
    () => SkillRemoteDataSourceImpl(supabaseClient),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient),
  );

  // Register the repositories
  getIt.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(
        remoteDataSource: getIt<SessionRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SkillRepository>(
    () => SkillRepositoryImpl(remoteDataSource: getIt<SkillRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );

  // Register the use cases
  getIt.registerFactory<SaveSessionUseCase>(
    () => SaveSessionUseCase(repository: getIt<SessionRepository>()),
  );
  getIt.registerFactory<LoadSessionsUseCase>(
    () => LoadSessionsUseCase(repository: getIt<SessionRepository>()),
  );
  getIt.registerFactory<LoadSkillsUseCase>(
    () => LoadSkillsUseCase(repository: getIt<SkillRepository>()),
  );
  getIt.registerFactory<CalculateDdUseCase>(
    () => CalculateDdUseCase(),
  );
  getIt.registerFactory<GetCurrentSessionUseCase>(
    () => GetCurrentSessionUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<LogOutUseCase>(
    () => LogOutUseCase(repository: getIt<AuthRepository>()),
  );

  // Register blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      getCurrentSession: getIt<GetCurrentSessionUseCase>(),
      getCurrentUser: getIt<GetCurrentUserUseCase>(),
      logOut: getIt<LogOutUseCase>(),
    ),
  );
  getIt.registerFactory<SkillBloc>(
    () => SkillBloc(
      session: getIt<SessionEntity>(),
      saveSessionUseCase: getIt<SaveSessionUseCase>(),
      calcDdUseCase: getIt<CalculateDdUseCase>(),
    ),
  );
  getIt.registerFactory<MonitorBloc>(
    () => MonitorBloc(
      loadSessions: getIt<LoadSessionsUseCase>(),
      loadSkills: getIt<LoadSkillsUseCase>(),
    ),
  );
}
