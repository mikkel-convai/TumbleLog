import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
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

  // Register the bloc (with dependencies injected)
  getIt.registerFactory<SkillBloc>(
    () => SkillBloc(
      session:
          getIt<SessionEntity>(), // Inject a session or pass it manually later
      saveSessionUseCase: getIt<SaveSessionUseCase>(),
    ),
  );
}
