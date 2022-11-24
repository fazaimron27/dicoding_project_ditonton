import 'package:tv/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_season.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';

final testTv = Tv(
  backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
  firstAirDate: '2022-08-21',
  genreIds: const [10765, 18, 10759],
  id: 94997,
  name: 'House of the Dragon',
  originCountry: const ['US'],
  originalLanguage: 'en',
  originalName: 'House of the Dragon',
  overview:
      'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
  popularity: 2620.574,
  posterPath: '/1X4h40fcB4WWUmIBK0auT4zRBAV.jpg',
  voteAverage: 8.5,
  voteCount: 2339,
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
  episodeRunTime: [60],
  firstAirDate: '2022-08-21',
  genres: [Genre(id: 10765, name: 'Sci-Fi & Fantasy')],
  id: 94997,
  name: 'House of the Dragon',
  nextEpisodeToAir: null,
  numberOfEpisodes: 10,
  numberOfSeasons: 1,
  originCountry: ['US'],
  originalLanguage: 'en',
  originalName: 'House of the Dragon',
  overview:
      'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
  popularity: 2695.468,
  posterPath: '/1X4h40fcB4WWUmIBK0auT4zRBAV.jpg',
  seasons: [
    TvSeason(
      airDate: '2022-08-21',
      episodeCount: 10,
      id: 134965,
      name: 'Season 1',
      overview: '',
      posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
      seasonNumber: 1,
    )
  ],
  tagline: 'Fire and blood.',
  voteAverage: 8.506,
  voteCount: 2338,
);

const testTvSeasonDetail = TvSeasonDetail(
  id: '5db952cca1d3320014e91171',
  airDate: '2022-08-21',
  episodes: [
    TvEpisode(
      airDate: '2022-08-21',
      episodeNumber: 1,
      id: 1971015,
      name: 'The Heirs of the Dragon',
      overview:
          'Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.',
      productionCode: '',
      runtime: 66,
      seasonNumber: 1,
      showId: 94997,
      stillPath: '/3oumSnkavc4pcMFvPbgWDUTclNb.jpg',
      voteAverage: 7.973,
      voteCount: 74,
    )
  ],
  name: 'Season 1',
  overview: '',
  tvSeasonDetailId: 134965,
  posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
  seasonNumber: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
