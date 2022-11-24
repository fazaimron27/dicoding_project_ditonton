import 'package:movie/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from movie table ', () async {
    const tMovieTable = MovieTable(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
    );

    final ttMovieTableJsonValue = {
      'id': 1,
      'title': 'title',
      'posterPath': 'posterPath',
      'overview': 'overview',
    };
    final result = tMovieTable.toJson();
    expect(result, ttMovieTableJsonValue);
  });
}
