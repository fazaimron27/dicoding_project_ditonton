import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/pages/now_playing_movies_page.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late MockNowPlayingMovieBloc mockNowPlayingMovieBloc;

  setUp(() {
    mockNowPlayingMovieBloc = MockNowPlayingMovieBloc();
    registerFallbackValue(MovieFakeEvent());
    registerFallbackValue(MovieFakeState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMoviesBloc>.value(
      value: mockNowPlayingMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(MovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display MovieCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(MovieHasData(testMovieList));

    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingMoviesPage()));

    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(const MovieError('Something went wrong'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
