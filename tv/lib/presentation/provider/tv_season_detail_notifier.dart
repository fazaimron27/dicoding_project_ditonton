import '../../domain/entities/tv_season_detail.dart';
import '../../domain/usecases/get_tv_season_detail.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailNotifier({
    required this.getTvSeasonDetail,
  });

  late TvSeasonDetail _tvSeason;
  TvSeasonDetail get tvSeason => _tvSeason;

  RequestState _tvSeasonState = RequestState.empty;
  RequestState get tvSeasonState => _tvSeasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonDetail(int id, int seasonNumber) async {
    _tvSeasonState = RequestState.loading;
    notifyListeners();

    final tvSeasonDetailResult =
        await getTvSeasonDetail.execute(id, seasonNumber);

    tvSeasonDetailResult.fold(
      (failure) {
        _tvSeasonState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeason) {
        _tvSeasonState = RequestState.loaded;
        _tvSeason = tvSeason;
        notifyListeners();
      },
    );
  }
}
