import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class OnTheAirTvBloc extends Bloc<TvEvent, TvState> {
  final GetOnTheAirTv _getOnTheAirTv;

  OnTheAirTvBloc(this._getOnTheAirTv) : super(TvEmpty()) {
    on<OnTheAirTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getOnTheAirTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(TvEmpty()) {
    on<OnPopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TvEmpty()) {
    on<OnTopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvEmpty()) {
    on<OnTvDetail>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvDetailHasData(data));
        },
      );
    });
  }
}

class TvSeasonDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvSeasonDetail _getTvSeasonDetail;

  TvSeasonDetailBloc(this._getTvSeasonDetail) : super(TvEmpty()) {
    on<OnTvSeasonDetail>((event, emit) async {
      emit(TvLoading());
      final result =
          await _getTvSeasonDetail.execute(event.id, event.seasonNumber);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvSeasonDetailHasData(data));
        },
      );
    });
  }
}

class TvRecommendationsBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationsBloc(this._getTvRecommendations) : super(TvEmpty()) {
    on<OnTvRecommendations>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class TvWatchlistBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistStatus _getWatchlistStatus;
  final GetWatchlistTv _getWatchlistTv;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvWatchlistBloc(
    this._getWatchlistStatus,
    this._getWatchlistTv,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(TvEmpty()) {
    on<OnTvWatchlistStatus>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchlistStatus.execute(event.id);

      emit(TvWatchlistStatus(result));
    });

    on<OnWatchlistTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });

    on<OnAddTvToWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await _saveWatchlist.execute(event.tv);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(const TvWatchlistMessage(watchlistAddSuccessMessage));
        },
      );
    });

    on<OnRemoveTvFromWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await _removeWatchlist.execute(event.tv);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(const TvWatchlistMessage(watchlistRemoveSuccessMessage));
        },
      );
    });
  }
}
