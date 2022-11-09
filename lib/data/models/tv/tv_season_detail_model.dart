import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/data/models/tv/tv_episode_model.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetailResponse extends Equatable {
  TvSeasonDetailResponse({
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
  final List<TvEpisodeModel> episodes;
  final String name;
  final String overview;
  final int tvSeasonDetailId;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailResponse(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<TvEpisodeModel>.from(
            json["episodes"].map((x) => TvEpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        tvSeasonDetailId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": episodes.map((episode) => episode.toJson()),
        "name": name,
        "overview": overview,
        "id": tvSeasonDetailId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
      id: id,
      airDate: airDate,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      tvSeasonDetailId: tvSeasonDetailId,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

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
