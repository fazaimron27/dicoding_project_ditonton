import 'package:dartz/dartz.dart';
import '../../entities/tv/tv_detail.dart';
import '../../repositories/tv_repository.dart';
import '../../../utils/failure.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
