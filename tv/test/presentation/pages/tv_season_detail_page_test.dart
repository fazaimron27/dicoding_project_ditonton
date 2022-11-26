import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/tv_season_detail_page.dart';
import 'package:tv/presentation/widgets/tv_episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late MockTvSeasonDetailBloc mockTvSeasonDetailBloc;

  setUp(() {
    mockTvSeasonDetailBloc = MockTvSeasonDetailBloc();
    registerFallbackValue(TvFakeEvent());
    registerFallbackValue(TvFakeState());
  });
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailBloc>.value(
      value: mockTvSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeasonDetailBloc.state).thenReturn(TvLoading());

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
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(const TvSeasonDetailHasData(testTvSeasonDetail));

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
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(const TvSeasonDetailHasData(testTvSeasonDetail));

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
    when(() => mockTvSeasonDetailBloc.state).thenReturn(const TvError('Error'));

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
