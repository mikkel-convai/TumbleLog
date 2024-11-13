// Mocks generated by Mockito 5.4.4 from annotations
// in tumblelog/test/features/tracking/data/datasources/remote_datasource.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tumblelog/core/models/session_model.dart' as _i7;
import 'package:tumblelog/core/models/skill_model.dart' as _i8;
import 'package:tumblelog/core/utils/failure.dart' as _i5;
import 'package:tumblelog/core/utils/success.dart' as _i6;
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SessionRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionRemoteDataSourceImpl extends _i1.Mock
    implements _i3.SessionRemoteDataSourceImpl {
  MockSessionRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Success>> saveSession(
    _i7.SessionModel? session,
    List<_i8.SkillModel>? skills,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSession,
          [
            session,
            skills,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>.value(
            _FakeEither_0<_i5.Failure, _i6.Success>(
          this,
          Invocation.method(
            #saveSession,
            [
              session,
              skills,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Success>>);

  @override
  _i4.Future<List<_i7.SessionModel>> loadSessions({String? athleteId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSessions,
          [],
          {#athleteId: athleteId},
        ),
        returnValue:
            _i4.Future<List<_i7.SessionModel>>.value(<_i7.SessionModel>[]),
      ) as _i4.Future<List<_i7.SessionModel>>);

  @override
  _i4.Future<List<_i7.SessionModel>> loadWeeklySessions(
    String? athleteId, {
    DateTime? fromDate,
    DateTime? toDate,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadWeeklySessions,
          [athleteId],
          {
            #fromDate: fromDate,
            #toDate: toDate,
          },
        ),
        returnValue:
            _i4.Future<List<_i7.SessionModel>>.value(<_i7.SessionModel>[]),
      ) as _i4.Future<List<_i7.SessionModel>>);
}
