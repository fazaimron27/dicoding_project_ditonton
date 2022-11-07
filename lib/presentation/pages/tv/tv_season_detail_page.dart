import 'package:ditonton/presentation/provider/tv/tv_season_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_episode_card_list.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_season_detail';

  final Map args;
  TvSeasonDetailPage({required this.args});

  @override
  _TvSeasonDetailPageState createState() => _TvSeasonDetailPageState();
}

class _TvSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeasonDetailNotifier>(context, listen: false)
          .fetchTvSeasonDetail(widget.args['id'], widget.args['seasonNumber']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeasonDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeasonState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeasonState == RequestState.Loaded) {
            final tvSeason = provider.tvSeason;
            return Scaffold(
              appBar: AppBar(
                title: Text(tvSeason.name),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeasonEpisode = tvSeason.episodes[index];
                    return TvEpisodeCard(tvSeasonEpisode);
                  },
                  itemCount: tvSeason.episodes.length,
                ),
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
