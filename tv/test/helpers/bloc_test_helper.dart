import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class TvFakeEvent extends Fake implements TvEvent {}

class TvFakeState extends Fake implements TvState {}

class MockOnTheAirTvBloc extends MockBloc<TvEvent, TvState>
    implements OnTheAirTvBloc {}

class MockPopularTvBloc extends MockBloc<TvEvent, TvState>
    implements PopularTvBloc {}

class MockTopRatedTvBloc extends MockBloc<TvEvent, TvState>
    implements TopRatedTvBloc {}

class MockTvDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvDetailBloc {}

class MockTvSeasonDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvSeasonDetailBloc {}

class MockTvRecommendationsBloc extends MockBloc<TvEvent, TvState>
    implements TvRecommendationsBloc {}

class MockTvWatchlistBloc extends MockBloc<TvEvent, TvState>
    implements TvWatchlistBloc {}
