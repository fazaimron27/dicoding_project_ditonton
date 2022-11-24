import 'package:dartz/dartz.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetOnTheAirTv {
  final TvRepository repository;

  GetOnTheAirTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvShows();
  }
}
