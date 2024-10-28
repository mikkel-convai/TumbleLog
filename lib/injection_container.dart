import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart';
import 'package:tumblelog/features/tracking/data/repositories/session_repository_impl.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';
import 'package:tumblelog/features/tracking/domain/usecases/save_session_usecase.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() async {
  final supabaseClient = Supabase.instance.client;

  // Register the data sources
  getIt.registerLazySingleton<SessionRemoteDataSource>(
    () => SessionRemoteDataSourceImpl(supabaseClient),
  );

  // Register the repositories
  getIt.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(
        remoteDataSource: getIt<SessionRemoteDataSource>()),
  );

  // Register the use cases
  getIt.registerFactory<SaveSessionUseCase>(
    () => SaveSessionUseCase(repository: getIt<SessionRepository>()),
  );
  getIt.registerFactory<LoadSessionsUseCase>(
    () => LoadSessionsUseCase(repository: getIt<SessionRepository>()),
  );
  getIt.registerFactory<LoadSkillsUseCase>(
    () => LoadSkillsUseCase(repository: getIt<SessionRepository>()),
  );

  // Register blocs
  getIt.registerFactory<SkillBloc>(
    () => SkillBloc(
      session: getIt<SessionEntity>(),
      saveSessionUseCase: getIt<SaveSessionUseCase>(),
    ),
  );
  getIt.registerFactory<MonitorBloc>(
    () => MonitorBloc(
      loadSessions: getIt<LoadSessionsUseCase>(),
      loadSkills: getIt<LoadSkillsUseCase>(),
    ),
  );
}
