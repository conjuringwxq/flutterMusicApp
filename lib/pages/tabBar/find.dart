import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:music_app/notifiers/find_notifier.dart';

import 'package:music_app/components/custom_app_bar.dart';
import 'package:music_app/components/banner_swiper.dart';
import 'package:music_app/components/entrance_scroll_view.dart';
import 'package:music_app/components/recommend_song_list.dart';
import 'package:music_app/components/newest_music.dart';
import 'package:music_app/components/ranking_list.dart';

class FindScreen extends StatefulWidget {
  FindScreen({Key key}) : super(key: key);

  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    FindNotifier findNotifier = context.watch<FindNotifier>();

    super.build(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: <Widget>[
          BannerSwiper(notifier: findNotifier),
          EntranceScrollView(notifier: findNotifier),
          RecommendSongList(notifier: findNotifier),
          NewestMusic(notifier: findNotifier),
          RankingList(notifier: findNotifier),
        ],
      ),
    );
  }
}
