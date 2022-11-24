// Mocks generated by Mockito 5.3.2 from annotations
// in tv/test/presentation/pages/tv_season_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:core/utils/state_enum.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv_season_detail.dart' as _i3;
import 'package:tv/domain/usecases/get_tv_season_detail.dart' as _i2;
import 'package:tv/presentation/provider/tv_season_detail_notifier.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvSeasonDetail_0 extends _i1.SmartFake
    implements _i2.GetTvSeasonDetail {
  _FakeGetTvSeasonDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSeasonDetail_1 extends _i1.SmartFake
    implements _i3.TvSeasonDetail {
  _FakeTvSeasonDetail_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvSeasonDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeasonDetailNotifier extends _i1.Mock
    implements _i4.TvSeasonDetailNotifier {
  MockTvSeasonDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvSeasonDetail get getTvSeasonDetail => (super.noSuchMethod(
        Invocation.getter(#getTvSeasonDetail),
        returnValue: _FakeGetTvSeasonDetail_0(
          this,
          Invocation.getter(#getTvSeasonDetail),
        ),
      ) as _i2.GetTvSeasonDetail);
  @override
  _i3.TvSeasonDetail get tvSeason => (super.noSuchMethod(
        Invocation.getter(#tvSeason),
        returnValue: _FakeTvSeasonDetail_1(
          this,
          Invocation.getter(#tvSeason),
        ),
      ) as _i3.TvSeasonDetail);
  @override
  _i5.RequestState get tvSeasonState => (super.noSuchMethod(
        Invocation.getter(#tvSeasonState),
        returnValue: _i5.RequestState.empty,
      ) as _i5.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> fetchTvSeasonDetail(
    int? id,
    int? seasonNumber,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchTvSeasonDetail,
          [
            id,
            seasonNumber,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
