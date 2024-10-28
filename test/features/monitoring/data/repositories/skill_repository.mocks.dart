// Mocks generated by Mockito 5.4.4 from annotations
// in tumblelog/test/features/monitoring/data/repositories/skill_repository.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tumblelog/core/entities/skill_entity.dart' as _i5;
import 'package:tumblelog/features/monitoring/data/datasources/skill_remote_datasource.dart'
    as _i2;
import 'package:tumblelog/features/monitoring/data/repositories/skill_repository.dart'
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

class _FakeSkillRemoteDataSource_0 extends _i1.SmartFake
    implements _i2.SkillRemoteDataSource {
  _FakeSkillRemoteDataSource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SkillRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockSkillRepositoryImpl extends _i1.Mock
    implements _i3.SkillRepositoryImpl {
  MockSkillRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SkillRemoteDataSource get remoteDataSource => (super.noSuchMethod(
        Invocation.getter(#remoteDataSource),
        returnValue: _FakeSkillRemoteDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
      ) as _i2.SkillRemoteDataSource);

  @override
  _i4.Future<List<_i5.SkillEntity>> loadSkills(String? sessionId) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadSkills,
          [sessionId],
        ),
        returnValue:
            _i4.Future<List<_i5.SkillEntity>>.value(<_i5.SkillEntity>[]),
      ) as _i4.Future<List<_i5.SkillEntity>>);
}
