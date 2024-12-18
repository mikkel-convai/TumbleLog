// Mocks generated by Mockito 5.4.4 from annotations
// in tumblelog/test/features/monitoring/domain/usecases/load_skills.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tumblelog/core/entities/skill_entity.dart' as _i5;
import 'package:tumblelog/features/monitoring/domain/repositories/skill_repository.dart'
    as _i2;
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart'
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

class _FakeSkillRepository_0 extends _i1.SmartFake
    implements _i2.SkillRepository {
  _FakeSkillRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoadSkillsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadSkillsUseCase extends _i1.Mock implements _i3.LoadSkillsUseCase {
  MockLoadSkillsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SkillRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSkillRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SkillRepository);

  @override
  _i4.Future<List<_i5.SkillEntity>> execute(String? sessionId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [sessionId],
        ),
        returnValue:
            _i4.Future<List<_i5.SkillEntity>>.value(<_i5.SkillEntity>[]),
      ) as _i4.Future<List<_i5.SkillEntity>>);
}
