import 'package:core/utils/state_enum.dart';
import 'package:tv/presentation/pages/tv_season_detail_page.dart';
import 'package:tv/presentation/provider/tv_season_detail_notifier.dart';
import 'package:tv/presentation/widgets/tv_episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_detail_page_test.mocks.dart';

@GenerateMocks([TvSeasonDetailNotifier])
void main() {
  late MockTvSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeasonState).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TvSeasonDetailPage(
      args: {
        'id': 1,
        'seasonNumber': 1,
      },
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeasonState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvSeason).thenReturn(testTvSeasonDetail);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TvSeasonDetailPage(
      args: {
        'id': 1,
        'seasonNumber': 1,
      },
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TvEpisodeCard when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeasonState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvSeason).thenReturn(testTvSeasonDetail);

    final tvEpisodeCardFinder = find.byType(TvEpisodeCard);

    await tester.pumpWidget(_makeTestableWidget(const TvSeasonDetailPage(
      args: {
        'id': 1,
        'seasonNumber': 1,
      },
    )));

    expect(tvEpisodeCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeasonState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvSeasonDetailPage(
      args: {
        'id': 1,
        'seasonNumber': 1,
      },
    )));

    expect(textFinder, findsOneWidget);
  });
}
