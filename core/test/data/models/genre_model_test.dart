import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from genre model ', () async {
    const tGenreModel = GenreModel(
      id: 1,
      name: 'name',
    );
    final tGenreModelJsonValue = {
      "id": 1,
      "name": 'name',
    };
    final result = tGenreModel.toJson();
    expect(result, tGenreModelJsonValue);
  });
}
