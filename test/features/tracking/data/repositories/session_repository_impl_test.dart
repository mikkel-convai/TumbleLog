import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/features/tracking/data/repositories/session_repository_impl.dart';

import '../datasources/remote_datasource.mocks.dart';

void main() {
  late SessionRepositoryImpl repository;
  late MockSessionRemoteDataSourceImpl mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockSessionRemoteDataSourceImpl();
    repository = SessionRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final sessionEntity = SessionEntity(
    id: 'sessionId1',
    athleteId: 'athleteId1',
    date: DateTime(2024, 10, 25),
    athleteName: 'John Doe',
  );

  final sessionModel = SessionModel(
    id: 'sessionId1',
    athleteId: 'athleteId1',
    date: DateTime(2024, 10, 25),
    athleteName: 'John Doe',
  );

  test('should save the session to in remote data source', () async {
    // Act
    await repository.saveSession(sessionEntity);

    // Assert
    verify(mockRemoteDataSource.saveSession(sessionModel));
  });
}
