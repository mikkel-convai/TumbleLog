import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tumblelog/features/auth/data/repositories/auth_repository.dart';
import 'package:tumblelog/features/auth/domain/repositories/auth_repository.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/update_user_usecase.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/home/data/datasources/admin_remote_datasource.dart';
import 'package:tumblelog/features/home/data/repositories/admin_repository.dart';
import 'package:tumblelog/features/home/domain/repositories/admin_repository.dart';
import 'package:tumblelog/features/home/domain/usecases/add_club.dart';
import 'package:tumblelog/features/home/domain/usecases/delete_club.dart';
import 'package:tumblelog/features/home/domain/usecases/fetch_clubs.dart';
import 'package:tumblelog/features/home/domain/usecases/fetch_users.dart';
import 'package:tumblelog/features/home/domain/usecases/update_user_club.dart';
import 'package:tumblelog/features/home/domain/usecases/update_user_role.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:tumblelog/features/monitoring/data/datasources/athlete_remote_datasource.dart';
import 'package:tumblelog/features/monitoring/data/datasources/skill_remote_datasource.dart';
import 'package:tumblelog/features/monitoring/data/repositories/athlete_repository.dart';
import 'package:tumblelog/features/monitoring/data/repositories/skill_repository.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/athlete_repository.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/skill_repository.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_athletes.dart';
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
  _initDataSources();
  _initRepos();
  _initUseCases();
  _initBlocs();
}

void _initDataSources() {
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
  getIt.registerLazySingleton<AthleteRemoteDataSource>(
    () => AthleteRemoteDataSourceImpl(supabaseClient),
  );
  getIt.registerLazySingleton<AdminRemoteDataSource>(
    () => AdminRemoteDataSourceImpl(supabaseClient),
  );
}

void _initRepos() {
// Register the repositories
  getIt.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(
        remoteDataSource: getIt<SessionRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SkillRepository>(
    () => SkillRepositoryImpl(remoteDataSource: getIt<SkillRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AthleteRepository>(
    () => AthleteRepositoryImpl(
        remoteDataSource: getIt<AthleteRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(remoteDataSource: getIt<AdminRemoteDataSource>()),
  );
}

void _initUseCases() {
  // Register the use cases
  getIt.registerFactory<SaveSessionUseCase>(
    () => SaveSessionUseCase(repository: getIt<SessionRepository>()),
  );
  getIt.registerFactory<LoadAthletesUseCase>(
    () => LoadAthletesUseCase(repository: getIt<AthleteRepository>()),
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
  getIt.registerFactory<FetchClubsUseCase>(
    () => FetchClubsUseCase(getIt<AdminRepository>()),
  );
  getIt.registerFactory<AddClubUseCase>(
    () => AddClubUseCase(getIt<AdminRepository>()),
  );
  getIt.registerFactory<DeleteClubUseCase>(
    () => DeleteClubUseCase(getIt<AdminRepository>()),
  );
  getIt.registerFactory<FetchUsersUseCase>(
    () => FetchUsersUseCase(getIt<AdminRepository>()),
  );
  getIt.registerFactory<UpdateUserRoleUseCase>(
    () => UpdateUserRoleUseCase(getIt<AdminRepository>()),
  );
  getIt.registerFactory<UpdateUserClubUseCase>(
    () => UpdateUserClubUseCase(getIt<AdminRepository>()),
  );
  getIt.registerFactory<UpdateUserUseCase>(
    () => UpdateUserUseCase(getIt<AuthRepository>()),
  );
}

void _initBlocs() {
  // Register blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      getCurrentSession: getIt<GetCurrentSessionUseCase>(),
      getCurrentUser: getIt<GetCurrentUserUseCase>(),
      logOut: getIt<LogOutUseCase>(),
      updateUser: getIt<UpdateUserUseCase>(),
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
      loadAthletes: getIt<LoadAthletesUseCase>(),
      loadSessions: getIt<LoadSessionsUseCase>(),
      loadSkills: getIt<LoadSkillsUseCase>(),
    ),
  );
  getIt.registerFactory<AdminBloc>(
    () => AdminBloc(
      fetchClubsUseCase: getIt<FetchClubsUseCase>(),
      addClubUseCase: getIt<AddClubUseCase>(),
      deleteClubUseCase: getIt<DeleteClubUseCase>(),
      fetchUsersUseCase: getIt<FetchUsersUseCase>(),
      updateUserRoleUseCase: getIt<UpdateUserRoleUseCase>(),
      updateUserClubUseCase: getIt<UpdateUserClubUseCase>(),
    ),
  );
}
