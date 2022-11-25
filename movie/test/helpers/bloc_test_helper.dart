import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

class MovieFakeEvent extends Fake implements MovieEvent {}

class MovieFakeState extends Fake implements MovieState {}

class MockNowPlayingMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMoviesBloc {}

class MockPopularMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMoviesBloc {}

class MockTopRatedMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMoviesBloc {}

class MockMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommendationsBloc {}

class MockMovieWatchlistBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieWatchlistBloc {}
