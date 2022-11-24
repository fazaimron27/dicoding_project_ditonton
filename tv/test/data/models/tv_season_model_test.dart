import 'package:tv/data/models/tv_season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from tv season model ', () async {
    const tTvSeasonModel = TvSeasonModel(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    );

    final tTvSeasonModelJsonValue = {
      "air_date": "airDate",
      "episode_count": 1,
      "id": 1,
      "name": "name",
      "overview": "overview",
      "poster_path": "posterPath",
      "season_number": 1,
    };
    final result = tTvSeasonModel.toJson();
    expect(result, tTvSeasonModelJsonValue);
  });
}
