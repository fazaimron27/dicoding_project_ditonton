part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class OnNowPlayingMovies extends MovieEvent {}

class OnPopularMovies extends MovieEvent {}

class OnTopRatedMovies extends MovieEvent {}

class OnMovieDetail extends MovieEvent {
  final int id;

  const OnMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnMovieRecommendations extends MovieEvent {
  final int id;

  const OnMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnMovieWatchlistStatus extends MovieEvent {
  final int id;

  const OnMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnWatchlistMovies extends MovieEvent {}

class OnAddMovieToWatchlist extends MovieEvent {
  final MovieDetail movie;

  const OnAddMovieToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveMovieFromWatchlist extends MovieEvent {
  final MovieDetail movie;

  const OnRemoveMovieFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}
