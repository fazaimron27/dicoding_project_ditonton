import 'package:core/utils/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import 'package:flutter/foundation.dart';

class NowPlayingMoviesNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesNotifier(this.getNowPlayingMovies);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}