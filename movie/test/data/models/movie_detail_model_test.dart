import 'package:core/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from movie detail model ', () async {
    const tGenreModel = GenreModel(
      id: 1,
      name: 'name',
    );

    const tMovieDetailResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 1,
      genres: [tGenreModel],
      homepage: 'homepage',
      id: 1,
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 1,
      runtime: 1,
      status: 'status',
      tagline: 'tagline',
      title: 'title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
    );

    final tMovieDetailResponseJsonValue = {
      "adult": false,
      "backdrop_path": "backdropPath",
      "budget": 1,
      "genres": [
        {
          "id": 1,
          "name": "name",
        }
      ],
      "homepage": "homepage",
      "id": 1,
      "imdb_id": "imdbId",
      "original_language": "originalLanguage",
      "original_title": "originalTitle",
      "overview": "overview",
      "popularity": 1.0,
      "poster_path": "posterPath",
      "release_date": "releaseDate",
      "revenue": 1,
      "runtime": 1,
      "status": "status",
      "tagline": "tagline",
      "title": "title",
      "video": false,
      "vote_average": 1.0,
      "vote_count": 1,
    };
    final result = tMovieDetailResponse.toJson();
    expect(result, tMovieDetailResponseJsonValue);
  });
}
