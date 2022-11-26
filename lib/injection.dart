/// Datasource Injection
/// Database Injection
import 'package:core/core.dart';

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

// import 'package:http/io_client.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() async {
  /// Search Bloc
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

  /// Movie Bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Tv Show Bloc
  locator.registerFactory(
    () => OnTheAirTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
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
      () => watchlist_status_movie.GetWatchlistStatus(locator()));
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
      () => watchlist_status_tv.GetWatchlistStatus(locator()));
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
  locator.registerLazySingleton(() => SSLPinning.client);
}
