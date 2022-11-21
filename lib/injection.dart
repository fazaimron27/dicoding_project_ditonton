/// Datasource Injection
/// Database Injection
import 'package:core/data/datasources/db/database_helper.dart';

/// Movie
import 'package:core/data/datasources/movie/movie_local_data_source.dart';
import 'package:core/data/datasources/movie/movie_remote_data_source.dart';

/// TV Show
import 'package:core/data/datasources/tv/tv_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_remote_data_source.dart';

/// Repository Injection
/// Movie
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';

/// TV Show
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/tv_repository.dart';

/// Use Case Injection
/// Movie
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart'
    as watchlist_status_movie;
import 'package:core/domain/usecases/movie/remove_watchlist.dart'
    as remove_watchlist_movie;
import 'package:core/domain/usecases/movie/save_watchlist.dart'
    as save_watchlist_movie;

/// TV Show
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status.dart'
    as watchlist_status_tv;
import 'package:core/domain/usecases/tv/remove_watchlist.dart'
    as remove_watchlist_tv;
import 'package:core/domain/usecases/tv/save_watchlist.dart'
    as save_watchlist_tv;
import 'package:core/domain/usecases/tv/get_tv_season_detail.dart';

/// Provider Injection
/// Movie
import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie/now_playing_movies_notifier.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';

/// TV Show
import 'package:core/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tv/tv_list_notifier.dart';
import 'package:core/presentation/provider/tv/on_the_air_tv_notifier.dart';
import 'package:core/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:core/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:core/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:core/presentation/provider/tv/tv_season_detail_notifier.dart';

// Search Module
import 'package:search/search.dart';

import 'package:search/presentation/bloc/search_bloc.dart';

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
    () => MovieSearchNotifier(
      searchMovies: locator(),
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
    () => TvSearchNotifier(
      searchTv: locator(),
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
