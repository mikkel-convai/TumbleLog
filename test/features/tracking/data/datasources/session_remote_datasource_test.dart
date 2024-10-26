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
      final requestBody = jsonDecode(body);

      if (url.contains('/rest/v1/sessions')) {
        // Check for invalid session ID
        if (requestBody['id'] == 'invalid_session') {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..headers.contentType = ContentType.json
            ..write(jsonEncode({'message': 'No sessions were uploaded'}))
            ..close();
          continue;
        }

        // Normal session insertion response
        final jsonString = jsonEncode([
          {
            'id': requestBody['id'],
            'athleteId': requestBody['athleteId'],
            'athleteName': requestBody['athleteName']
          }
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonString)
          ..close();
      } else if (url.contains('/rest/v1/skills')) {
        // Check for invalid skill ID
        if (requestBody is List &&
            requestBody.any((skill) => skill['id'] == 'invalid_skill')) {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..headers.contentType = ContentType.json
            ..write(jsonEncode({'message': 'No skills were uploaded'}))
            ..close();
          continue;
        }

        // Normal skills insertion response
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
      } else {
        // Return an empty response for any other request
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write('[]')
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
    handleRequests(mockServer);
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
  });
}
