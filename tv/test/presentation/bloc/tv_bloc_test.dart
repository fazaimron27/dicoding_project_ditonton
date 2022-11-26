import 'package:core/utils/failure.dart';
import 'package:tv/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tv_bloc_test.mocks.dart';

import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([
  GetOnTheAirTv,
  GetPopularTv,
  GetTopRatedTv,
  GetTvDetail,
  GetTvSeasonDetail,
  GetTvRecommendations,
  GetWatchlistStatus,
  GetWatchlistTv,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late OnTheAirTvBloc onTheAirTvBloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;

  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  late TvSeasonDetailBloc tvSeasonDetailBloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(
    () {
      mockGetOnTheAirTv = MockGetOnTheAirTv();
      onTheAirTvBloc = OnTheAirTvBloc(mockGetOnTheAirTv);
      mockGetPopularTv = MockGetPopularTv();
      popularTvBloc = PopularTvBloc(mockGetPopularTv);
      mockGetTopRatedTv = MockGetTopRatedTv();
      topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
      mockGetTvDetail = MockGetTvDetail();
      tvDetailBloc = TvDetailBloc(mockGetTvDetail);
      mockGetTvSeasonDetail = MockGetTvSeasonDetail();
      tvSeasonDetailBloc = TvSeasonDetailBloc(mockGetTvSeasonDetail);
      mockGetTvRecommendations = MockGetTvRecommendations();
      tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
      mockGetWatchlistStatus = MockGetWatchlistStatus();
      mockGetWatchlistTv = MockGetWatchlistTv();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      tvWatchlistBloc = TvWatchlistBloc(
        mockGetWatchlistStatus,
        mockGetWatchlistTv,
        mockSaveWatchlist,
        mockRemoveWatchlist,
      );
    },
  );

  group('on the air tv', () {
    test('initial state should be empty', () {
      expect(onTheAirTvBloc.state, TvEmpty());
    });

    blocTest<OnTheAirTvBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(OnTheAirTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<OnTheAirTvBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(OnTheAirTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );
  });

  group('popular tv', () {
    test('initial state should be empty', () {
      expect(popularTvBloc.state, TvEmpty());
    });

    blocTest<PopularTvBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });

  group('top rated tv', () {
    test('initial state should be empty', () {
      expect(topRatedTvBloc.state, TvEmpty());
    });

    blocTest<TopRatedTvBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });

  group('tv detail', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvEmpty());
    });

    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvDetailHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });

  group('tv season detail', () {
    test('initial state should be empty', () {
      expect(tvSeasonDetailBloc.state, TvEmpty());
    });

    blocTest<TvSeasonDetailBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => const Right(testTvSeasonDetail));
        return tvSeasonDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvSeasonDetail(tId, tSeasonNumber)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvSeasonDetailHasData(testTvSeasonDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvSeasonDetail.execute(tId, tSeasonNumber));
      },
    );

    blocTest<TvSeasonDetailBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeasonDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvSeasonDetail(tId, tSeasonNumber)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeasonDetail.execute(tId, tSeasonNumber));
      },
    );
  });

  group('tv recommendations', () {
    test('initial state should be empty', () {
      expect(tvRecommendationsBloc.state, TvEmpty());
    });

    blocTest<TvRecommendationsBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnTvRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvRecommendationsBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnTvRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('tv watchlist', () {
    test('initial state should be empty', () {
      expect(tvWatchlistBloc.state, TvEmpty());
    });

    group('tv watchlist status', () {
      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnTvWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistStatus(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        },
      );
    });

    group('watchlist tv', () {
      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right(testTvList));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          TvHasData(testTvList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );
    });

    group('add tv to watchlist', () {
      const tWatchlistAddSuccessMessage =
          TvWatchlistBloc.watchlistAddSuccessMessage;

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async => const Right(tWatchlistAddSuccessMessage));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnAddTvToWatchlist(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistMessage(tWatchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvDetail));
        },
      );

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnAddTvToWatchlist(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvDetail));
        },
      );
    });

    group('remove tv from watchlist', () {
      const tWatchlistRemoveSuccessMessage =
          TvWatchlistBloc.watchlistRemoveSuccessMessage;

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async => const Right(tWatchlistRemoveSuccessMessage));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveTvFromWatchlist(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistMessage(tWatchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
        },
      );

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveTvFromWatchlist(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
        },
      );
    });
  });
}
