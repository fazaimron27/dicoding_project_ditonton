import '../widgets/tv_episode_card_list.dart';
import '../bloc/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeasonDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv-season';

  final Map args;
  const TvSeasonDetailPage({required this.args, Key? key}) : super(key: key);

  @override
  State<TvSeasonDetailPage> createState() => _TvSeasonDetailPageState();
}

class _TvSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeasonDetailBloc>().add(
          OnTvSeasonDetail(widget.args['id'], widget.args['seasonNumber'])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeasonDetailBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeasonDetailHasData) {
            final tvSeason = state.result;
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
          } else if (state is TvError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
