import 'package:core/utils/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier])
void main() {
  late MockWatchlistMovieNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistMovieNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  // testWidgets('Page should display ListView when data is loaded',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.watchlistMovies).thenReturn(<Movie>[]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

  //   expect(listViewFinder, findsOneWidget);
  // });

  testWidgets('Page should display MovieCard when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
    when(mockNotifier.watchlistMovies).thenReturn(<Movie>[testMovie]);

    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}