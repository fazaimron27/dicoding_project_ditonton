import 'package:dartz/dartz.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvShowRecommendations(id);
  }
}
