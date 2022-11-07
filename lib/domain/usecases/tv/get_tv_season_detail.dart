import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail(this.repository);

  Future<Either<Failure, TvSeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getTvShowSeasonDetail(id, seasonNumber);
  }
}
