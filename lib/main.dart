import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

/// Core Module
import 'package:core/core.dart';

/// About Module
import 'package:about/about.dart';

/// Search Module
import 'package:search/search.dart';

/// Movie Module
import 'package:movie/movie.dart';

/// TV Show Module
import 'package:tv/tv.dart';

/// Firebase
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeasonDetailNotifier>(),
        ),

        /// Search Module
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeMovieRoute:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case nowPlayingRoute:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviesPage());
            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviesRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case movieSearchRoute:
              return CupertinoPageRoute(builder: (_) => MovieSearchPage());
            case watchlistMovieRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case homeTvRoute:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case onTheAirRoute:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvPage());
            case popularTvRoute:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case topRatedTvRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case tvDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case tvSearchRoute:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case watchlistTvRoute:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case tvSeasonDetailRoute:
              final args = settings.arguments as Map;
              return MaterialPageRoute(
                builder: (_) => TvSeasonDetailPage(args: args),
                settings: settings,
              );
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
