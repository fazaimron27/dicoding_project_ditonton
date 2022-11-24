import 'package:tv/data/models/tv_episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from tv episode model ', () async {
    const tTvEpisodeModel = TvEpisodeModel(
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

    final tTvEpisodeModelJsonValue = {
      "air_date": "airDate",
      "episode_number": 1,
      "id": 1,
      "name": "name",
      "overview": "overview",
      "production_code": "productionCode",
      "runtime": 1,
      "season_number": 1,
      "show_id": 1,
      "still_path": "stillPath",
      "vote_average": 1,
      "vote_count": 1,
    };
    final result = tTvEpisodeModel.toJson();
    expect(result, tTvEpisodeModelJsonValue);
  });
}
