import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be convert to json value from tv table ', () async {
    final tTvTable = TvTable(
      id: 1,
      name: 'name',
      posterPath: 'posterPath',
      overview: 'overview',
    );

    final tTvTableJsonValue = {
      'id': 1,
      'name': 'name',
      'posterPath': 'posterPath',
      'overview': 'overview',
    };
    final result = tTvTable.toJson();
    expect(result, tTvTableJsonValue);
  });
}
