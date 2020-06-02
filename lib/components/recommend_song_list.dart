import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/models/find_model.dart';

import 'module_title_bar.dart';

class RecommendSongList extends StatelessWidget {
  final FindModel model;

  const RecommendSongList({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ModuleTitleBar(
          title: "推荐歌单",
          trailingLabel: "查看更多",
          hideTrailingIcon: true,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: model.getPersonalized(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CupertinoActivityIndicator(radius: 16.0);
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Row(
                  children: snapshot.data.map((item) {
                    return Container(
                      width: 110.0,
                      padding: EdgeInsets.only(right: 13.0),
                      child: Column(
                        children: <Widget>[
                          SongListItem(obj: item),
                          Text(
                            "${item['name']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SongListItem extends StatelessWidget {
  final Map<String, dynamic> obj;

  SongListItem({Key key, this.obj}) : super(key: key);

  String handlerPlayCount(int playCount) {
    if (playCount ~/ 10000 > 1 && playCount ~/ 100000000 < 1) {
      return "${playCount ~/ 10000}万";
    } else if (playCount ~/ 100000000 > 1) {
      return "${playCount ~/ 100000000}亿";
    }
    return playCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.network("${obj['picUrl']}"),
          Positioned(
            child: Row(
              children: <Widget>[
                Icon(
                  IconData(0xe616, fontFamily: 'iconfont'),
                  color: Colors.white,
                  size: 14.0,
                ),
                Text(
                  "${handlerPlayCount(obj['playCount'])}",
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                )
              ],
            ),
            top: 2.0,
            right: 6.0,
          ),
        ],
      ),
    );
  }
}
