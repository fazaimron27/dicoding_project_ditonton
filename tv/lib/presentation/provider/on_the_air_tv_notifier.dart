import 'package:core/utils/state_enum.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter/foundation.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvNotifier(this.getOnTheAirTv);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
