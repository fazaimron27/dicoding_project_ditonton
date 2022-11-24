import 'package:dartz/dartz.dart';
import '../entities/tv_season_detail.dart';
import '../repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail(this.repository);

  Future<Either<Failure, TvSeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getTvShowSeasonDetail(id, seasonNumber);
  }
}
