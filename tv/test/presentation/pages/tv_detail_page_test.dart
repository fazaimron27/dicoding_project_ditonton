import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    registerFallbackValue(TvFakeEvent());
    registerFallbackValue(TvFakeState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>.value(value: mockTvDetailBloc),
        BlocProvider<TvRecommendationsBloc>.value(
            value: mockTvRecommendationsBloc),
        BlocProvider<TvWatchlistBloc>.value(value: mockTvWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv show is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

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
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(true));

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
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(const TvError('Failed'));

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
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvLoading());
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(circularProgressIndicator, findsWidgets);
  });

  testWidgets(
      'Page should display ListView when data recommendation tv show is loaded',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    final listView = find.byKey(const Key('recommendationsListView'));

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(listView, findsOneWidget);
  });
}
