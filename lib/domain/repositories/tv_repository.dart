import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShows();
  Future<Either<Failure, List<Tv>>> getPopularTvShows();
  Future<Either<Failure, List<Tv>>> getTopRatedTvShows();
  Future<Either<Failure, TvDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
