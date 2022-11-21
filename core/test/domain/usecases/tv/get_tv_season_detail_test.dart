import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasonDetail(mockTvRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('should get tv show season detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvShowSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testTvSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(testTvSeasonDetail));
  });
}