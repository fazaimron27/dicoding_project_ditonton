import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTv = MockGetTopRatedTv();
    notifier = TopRatedTvNotifier(getTopRatedTv: mockGetTopRatedTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTv.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
