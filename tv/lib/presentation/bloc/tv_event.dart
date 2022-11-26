part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class OnTheAirTv extends TvEvent {}

class OnPopularTv extends TvEvent {}

class OnTopRatedTv extends TvEvent {}

class OnTvDetail extends TvEvent {
  final int id;

  const OnTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnTvSeasonDetail extends TvEvent {
  final int id;
  final int seasonNumber;

  const OnTvSeasonDetail(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}

class OnTvRecommendations extends TvEvent {
  final int id;

  const OnTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnTvWatchlistStatus extends TvEvent {
  final int id;

  const OnTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnWatchlistTv extends TvEvent {}

class OnAddTvToWatchlist extends TvEvent {
  final TvDetail tv;

  const OnAddTvToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class OnRemoveTvFromWatchlist extends TvEvent {
  final TvDetail tv;

  const OnRemoveTvFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}
