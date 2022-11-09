import 'package:ditonton/data/models/tv/tv_season_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from tv season detail model ',
      () async {
    final tTvEpisodeModel = TvEpisodeModel(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
    );

    final tTvSeasonDetailResponse = TvSeasonDetailResponse(
      id: 'id',
      airDate: 'airDate',
      episodes: [tTvEpisodeModel],
      name: 'name',
      overview: 'overview',
      tvSeasonDetailId: 1,
      posterPath: 'posterPath',
      seasonNumber: 1,
    );

    final tTvSeasonDetailResponseJsonValue = {
      "_id": 'id',
      "air_date": 'airDate',
      "episodes": [
        {
          "air_date": 'airDate',
          "episode_number": 1,
          "id": 1,
          "name": 'name',
          "overview": 'overview',
          "production_code": 'productionCode',
          "runtime": 1,
          "season_number": 1,
          "show_id": 1,
          "still_path": 'stillPath',
          "vote_average": 1,
          "vote_count": 1,
        }
      ],
      "name": 'name',
      "overview": 'overview',
      "id": 1,
      "poster_path": 'posterPath',
      "season_number": 1,
    };
    final result = tTvSeasonDetailResponse.toJson();
    expect(result, tTvSeasonDetailResponseJsonValue);
  });
}
