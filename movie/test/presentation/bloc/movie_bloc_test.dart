import 'package:core/utils/failure.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'movie_bloc_test.mocks.dart';

import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistStatus,
  GetWatchlistMovies,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      mockGetWatchlistStatus,
      mockGetWatchlistMovies,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  group('now playing movies', () {
    test('initial state should be empty', () {
      expect(nowPlayingMoviesBloc.state, MovieEmpty());
    });

    blocTest<NowPlayingMoviesBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('popular movies', () {
    test('initial state should be empty', () {
      expect(popularMoviesBloc.state, MovieEmpty());
    });

    blocTest<PopularMoviesBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnPopularMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnPopularMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('top rated movies', () {
    test('initial state should be empty', () {
      expect(topRatedMoviesBloc.state, MovieEmpty());
    });

    blocTest<TopRatedMoviesBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('movie detail', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state, MovieEmpty());
    });

    blocTest<MovieDetailBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnMovieDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        const MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnMovieDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('movie recommendations', () {
    test('initial state should be empty', () {
      expect(movieRecommendationsBloc.state, MovieEmpty());
    });

    blocTest<MovieRecommendationsBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationsBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('movie watchlist', () {
    test('initial state should be empty', () {
      expect(movieWatchlistBloc.state, MovieEmpty());
    });

    group('movie watchlist status', () {
      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnMovieWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieWatchlistStatus(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        },
      );
    });

    group('watchlist movies', () {
      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          MovieHasData(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    });

    group('add movie to watchlist', () {
      const tWatchlistAddSuccessMessage =
          MovieWatchlistBloc.watchlistAddSuccessMessage;

      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(tWatchlistAddSuccessMessage));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnAddMovieToWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieWatchlistMessage(tWatchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnAddMovieToWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );
    });

    group('remove movie from watchlist', () {
      const tWatchlistRemoveSuccessMessage =
          MovieWatchlistBloc.watchlistRemoveSuccessMessage;

      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(tWatchlistRemoveSuccessMessage));
          return movieWatchlistBloc;
        },
        act: (bloc) =>
            bloc.add(const OnRemoveMovieFromWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieWatchlistMessage(tWatchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<MovieWatchlistBloc, MovieState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieWatchlistBloc;
        },
        act: (bloc) =>
            bloc.add(const OnRemoveMovieFromWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );
    });
  });
}
