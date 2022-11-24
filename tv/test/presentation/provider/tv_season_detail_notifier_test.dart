import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/presentation/provider/tv_season_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailNotifier provider;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    provider = TvSeasonDetailNotifier(
      getTvSeasonDetail: mockGetTvSeasonDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;
  const tSeasonNumber = 1;

  // ignore: no_leading_underscores_for_local_identifiers
  void _arrangeUsecase() {
    when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testTvSeasonDetail));
  }

  group('Get Tv Show Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockGetTvSeasonDetail.execute(tId, tSeasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show season when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.loaded);
      expect(provider.tvSeason, testTvSeasonDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
