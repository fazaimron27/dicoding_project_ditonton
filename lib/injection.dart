/// Datasource Injection
/// Database Injection
import 'package:core/data/datasources/db/database_helper.dart';

/// Use Case Injection
/// Movie
import 'package:movie/domain/usecases/get_watchlist_status.dart'
    as watchlist_status_movie;
import 'package:movie/domain/usecases/remove_watchlist.dart'
    as remove_watchlist_movie;
import 'package:movie/domain/usecases/save_watchlist.dart'
    as save_watchlist_movie;

/// Tv Show
import 'package:tv/domain/usecases/get_watchlist_status.dart'
    as watchlist_status_tv;
import 'package:tv/domain/usecases/remove_watchlist.dart'
    as remove_watchlist_tv;
import 'package:tv/domain/usecases/save_watchlist.dart' as save_watchlist_tv;

// Search Module
import 'package:search/search.dart';

/// Movie Module
import 'package:movie/movie.dart';

/// TV Show Module
import 'package:tv/tv.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  /// provider
  /// Movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  /// TV Show
  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonDetailNotifier(
      getTvSeasonDetail: locator(),
    ),
  );

  /// bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );

  /// use case
  /// Movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(
      () => watchlist_status_movie.GetWatchListStatus(locator()));
  locator.registerLazySingleton(
      () => save_watchlist_movie.SaveWatchlist(locator()));
  locator.registerLazySingleton(
      () => remove_watchlist_movie.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  /// TV Show
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(
      () => watchlist_status_tv.GetWatchListStatus(locator()));
  locator
      .registerLazySingleton(() => save_watchlist_tv.SaveWatchlist(locator()));
  locator.registerLazySingleton(
      () => remove_watchlist_tv.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetTvSeasonDetail(locator()));

  /// repository
  /// Movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /// TV Show
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /// data sources
  /// Movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  /// TV Show
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  /// helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  /// external
  locator.registerLazySingleton(() => http.Client());
}
