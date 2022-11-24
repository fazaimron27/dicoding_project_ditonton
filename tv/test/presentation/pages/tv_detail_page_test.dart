import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv show is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Page should display progress bar when loading tv show recommendations',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loading);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(circularProgressIndicator, findsWidgets);
  });

  testWidgets(
      'Page should display ListView when data recommendation tv show is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[testTv]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final listView = find.byKey(const Key('recommendationListView'));

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(listView, findsOneWidget);
  });
}
