import '../repositories/tv_repository.dart';

class GetWatchlistStatus {
  final TvRepository repository;

  GetWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
