import 'package:flutter_test/flutter_test.dart';
import 'package:tumblelog/core/models/session_model.dart';

void main() {
  group('SessionModel', () {
    final sessionModel = SessionModel(
      id: 'session123',
      athleteId: 'athlete456',
      date: DateTime.parse('2023-10-26'),
      athleteName: 'Grisha',
    );

    final sessionJson = {
      'id': 'session123',
      'athleteId': 'athlete456',
      'athleteName': 'Grisha',
      'date': '2023-10-26T00:00:00.000',
    };

    test('should correctly convert from JSON', () {
      final result = SessionModel.fromJson(sessionJson);
      expect(result, sessionModel);
    });

    test('should correctly convert to JSON', () {
      final result = sessionModel.toJson();
      expect(result, sessionJson);
    });

    test('should support value equality', () {
      final otherSession = SessionModel(
        id: 'session123',
        athleteId: 'athlete456',
        date: DateTime.parse('2023-10-26'),
        athleteName: 'Grisha',
      );
      expect(sessionModel, equals(otherSession));
    });

    test('should have correct props', () {
      expect(sessionModel.props, [
        sessionModel.id,
        sessionModel.athleteId,
        sessionModel.athleteName,
        sessionModel.date,
      ]);
    });
  });
}
