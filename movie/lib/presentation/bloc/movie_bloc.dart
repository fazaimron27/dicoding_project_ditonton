import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class NowPlayingMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MovieEmpty()) {
    on<OnNowPlayingMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class PopularMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MovieEmpty()) {
    on<OnPopularMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class TopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MovieEmpty()) {
    on<OnTopRatedMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieEmpty()) {
    on<OnMovieDetail>((event, emit) async {
      emit(MovieLoading());
      final result = await _getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieDetailHasData(data));
        },
      );
    });
  }
}

class MovieRecommendationsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieEmpty()) {
    on<OnMovieRecommendations>((event, emit) async {
      emit(MovieLoading());
      final result = await _getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class MovieWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistStatus _getWatchlistStatus;
  final GetWatchlistMovies _getWatchlistMovies;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc(
    this._getWatchlistStatus,
    this._getWatchlistMovies,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(MovieEmpty()) {
    on<OnMovieWatchlistStatus>((event, emit) async {
      emit(MovieLoading());
      final result = await _getWatchlistStatus.execute(event.id);

      emit(MovieWatchlistStatus(result));
    });

    on<OnWatchlistMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });

    on<OnAddMovieToWatchlist>((event, emit) async {
      emit(MovieLoading());
      final result = await _saveWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(const MovieWatchlistMessage(watchlistAddSuccessMessage));
        },
      );
    });

    on<OnRemoveMovieFromWatchlist>((event, emit) async {
      emit(MovieLoading());
      final result = await _removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(const MovieWatchlistMessage(watchlistRemoveSuccessMessage));
        },
      );
    });
  }
}
