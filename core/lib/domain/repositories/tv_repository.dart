import 'package:dartz/dartz.dart';
import '../entities/tv/tv.dart';
import '../entities/tv/tv_detail.dart';
import '../entities/tv/tv_season_detail.dart';
import '../../../utils/failure.dart';

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
  Future<Either<Failure, TvSeasonDetail>> getTvShowSeasonDetail(
      int id, int seasonNumber);
}
