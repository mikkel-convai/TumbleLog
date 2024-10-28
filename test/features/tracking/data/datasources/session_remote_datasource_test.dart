import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/core/utils/success.dart';
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart';

void main() {
  late SupabaseClient client;
  late HttpServer mockServer;
  late SessionRemoteDataSourceImpl dataSource;
  const apiKey = 'supabaseKey';

  // Test session and skills data
  final session = SessionModel(
    id: 'session1',
    athleteId: 'athlete1',
    date: DateTime.now(),
    athleteName: 'John Doe',
  );

  final skills = [
    const SkillModel(
      id: 'skill1',
      sessionId: 'session1',
      name: 'Skill 1',
      symbol: '^',
      difficulty: 1.0,
      equipmentReps: {},
    ),
  ];

  Future<void> handleRequests(HttpServer server) async {
    await for (final HttpRequest request in server) {
      final url = request.uri.toString();
      final body = await utf8.decoder.bind(request).join();
      final requestBody = body.isNotEmpty ? jsonDecode(body) : null;

      if (url.contains('/rest/v1/sessions')) {
        if (requestBody != null &&
            requestBody is Map &&
            requestBody['id'] == 'invalid_session') {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..headers.contentType = ContentType.json
            ..write(jsonEncode({'message': 'No sessions were uploaded'}))
            ..close();
        } else {
          final jsonString = jsonEncode([
            {
              'id': 'session1',
              'athleteId': 'athlete1',
              'athleteName': 'John Doe',
              'date': DateTime.now().toIso8601String(),
            },
            {
              'id': 'session2',
              'athleteId': 'athlete2',
              'athleteName': 'Jane Doe',
              'date': DateTime.now().toIso8601String(),
            },
          ]);
          request.response
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.json
            ..write(jsonString)
            ..close();
        }
      } else if (url.contains('/rest/v1/skills')) {
        if (requestBody is List &&
            requestBody.any((skill) => skill['id'] == 'invalid_skill')) {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..headers.contentType = ContentType.json
            ..write(jsonEncode({'message': 'No skills were uploaded'}))
            ..close();
        } else {
          final jsonString = jsonEncode([
            {
              'id': 'skill1',
              'sessionId': 'session1',
              'name': 'Skill 1',
              'symbol': '^'
            }
          ]);
          request.response
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.json
            ..write(jsonString)
            ..close();
        }
      } else {
        // Default response for unexpected endpoints
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write('[]') // Ensure JSON array response to avoid parsing errors
          ..close();
      }
    }
  }

  setUp(() async {
    mockServer = await HttpServer.bind('localhost', 0);
    client = SupabaseClient(
      'http://${mockServer.address.host}:${mockServer.port}',
      apiKey,
      headers: {
        'X-Client-Info': 'supabase-flutter/0.0.0',
      },
    );
    dataSource = SessionRemoteDataSourceImpl(client);

    // Ensure handleRequests completes before tests run
    unawaited(handleRequests(mockServer));
  });

  tearDown(() async {
    await client.dispose();
    await mockServer.close();
  });

  group('SessionRemoteDataSourceImpl', () {
    test(
        'should return Success when session and skills are uploaded successfully',
        () async {
      // Act
      final result = await dataSource.saveSession(session, skills);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.getOrElse(() => Success(message: 'Session uploaded')).message,
          'Session uploaded.');
    });

    test('should return Failure when session upload fails', () async {
      // Act
      final result = await dataSource.saveSession(
        SessionModel(
          id: 'invalid_session', // This ID triggers the failure response
          athleteId: 'athlete1',
          date: DateTime.now(),
          athleteName: 'John Doe',
        ),
        skills,
      );

      // Assert
      expect(result, isA<Left>());
      result.fold(
        (failure) =>
            expect(failure.message, contains('No sessions were uploaded')),
        (_) => fail('Expected a Failure'),
      );
    });

    test('should return Failure when skills upload fails', () async {
      // Act
      final result = await dataSource.saveSession(
        session,
        [
          const SkillModel(
              id: 'invalid_skill',
              sessionId: 'session1',
              name: 'Invalid Skill',
              symbol: 'X',
              difficulty: 0.0,
              equipmentReps: {})
        ],
      );

      // Assert
      expect(result, isA<Left>());
      result.fold(
        (failure) =>
            expect(failure.message, contains('No skills were uploaded')),
        (_) => fail('Expected a Failure'),
      );
    });

    test('should return Failure when an exception occurs', () async {
      // Arrange
      await mockServer.close(); // Force an error by closing the server

      // Act
      final result = await dataSource.saveSession(session, skills);

      // Assert
      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(
            failure.message, contains('Error saving session and skills:')),
        (_) => fail('Expected a Failure'),
      );
    });

    // test('should return a list of SessionModel when loadSessions is called',
    //     () async {
    //   // Act
    //   final sessions = await dataSource.loadSessions();

    //   // Assert
    //   expect(sessions, isA<List<SessionModel>>());
    //   expect(sessions.length, 2);

    //   expect(sessions[0].id, 'session1');
    //   expect(sessions[0].athleteId, 'athlete1');
    //   expect(sessions[0].athleteName, 'John Doe');
    //   expect(sessions[1].id, 'session2');
    //   expect(sessions[1].athleteId, 'athlete2');
    //   expect(sessions[1].athleteName, 'Jane Doe');
    // });

    test('should return an empty list when there are no sessions', () async {
      // Close the mock server and set up a new handler that returns an empty list
      await mockServer.close();
      mockServer = await HttpServer.bind('localhost', 0);
      handleRequests(mockServer);

      // Act
      final sessions = await dataSource.loadSessions();

      // Assert
      expect(sessions, isEmpty);
    });

    test(
        'should handle errors and return an empty list when an exception occurs',
        () async {
      // Arrange
      await mockServer.close(); // Force an error by closing the server

      // Act
      final sessions = await dataSource.loadSessions();

      // Assert
      expect(sessions, isEmpty);
    });
  });
}
