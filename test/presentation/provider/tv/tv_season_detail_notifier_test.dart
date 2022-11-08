import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/provider/tv/tv_season_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects.dart';
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

  final tId = 1;
  final tSeasonNumber = 1;

  void _arrangeUsecase() {
    when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testTvSeasonDetail));
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
      expect(provider.tvSeasonState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show season when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.Loaded);
      expect(provider.tvSeason, testTvSeasonDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
