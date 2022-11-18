import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from tv detail model ', () async {
    const tGenreModel = GenreModel(
      id: 1,
      name: 'name',
    );

    const tTvDetailResponse = TvDetailResponse(
      backdropPath: 'backdropPath',
      episodeRunTime: [1],
      firstAirDate: 'firstAirDate',
      genres: [tGenreModel],
      homepage: 'homepage',
      id: 1,
      lastAirDate: 'lastAirDate',
      name: 'name',
      nextEpisodeToAir: null,
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      seasons: [],
      status: 'status',
      tagline: 'tagline',
      voteAverage: 1.0,
      voteCount: 1,
    );

    final tTvDetailResponseJsonValue = {
      "backdrop_path": "backdropPath",
      "episode_run_time": [1],
      "first_air_date": "firstAirDate",
      "genres": [
        {
          "id": 1,
          "name": "name",
        }
      ],
      "homepage": "homepage",
      "id": 1,
      "last_air_date": "lastAirDate",
      "name": "name",
      "next_episode_to_air": null,
      "number_of_episodes": 1,
      "number_of_seasons": 1,
      "origin_country": ["originCountry"],
      "original_language": "originalLanguage",
      "original_name": "originalName",
      "overview": "overview",
      "popularity": 1.0,
      "poster_path": "posterPath",
      "seasons": [],
      "status": "status",
      "tagline": "tagline",
      "vote_average": 1.0,
      "vote_count": 1,
    };
    final result = tTvDetailResponse.toJson();
    expect(result, tTvDetailResponseJsonValue);
  });
}
