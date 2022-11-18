import 'tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetail extends Equatable {
  const TvSeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.tvSeasonDetailId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String? airDate;
  final List<TvEpisode> episodes;
  final String name;
  final String overview;
  final int tvSeasonDetailId;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        tvSeasonDetailId,
        posterPath,
        seasonNumber,
      ];
}
