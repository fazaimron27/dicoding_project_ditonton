import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  final tGenreModelJsonValue = {
    "id": 1,
    "name": 'name',
  };

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be convert to Genre model', () async {
    final result = GenreModel.fromJson(tGenreModelJsonValue);
    expect(result, tGenreModel);
  });

  test('should be convert to json value from Genre model ', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreModelJsonValue);
  });
}
