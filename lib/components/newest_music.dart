import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music_app/models/find_model.dart';

import 'module_title_bar.dart';

class NewestMusic extends StatelessWidget {
  final FindModel model;
  final PageController controller = new PageController(viewportFraction: 0.9);

  NewestMusic({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ModuleTitleBar(
          title: "最新音乐",
          trailingLabel: "最新音乐",
          trailingIcon: Icons.play_arrow,
        ),
        Container(
          height: 200.0,
          child: FutureBuilder(
            future: model.getNewSong(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CupertinoActivityIndicator(radius: 16.0);
              }
              return PageView.builder(
                controller: controller,
                itemCount: (snapshot.data.length / 3).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Column(
                      children: <NewestMusicItem>[
                        NewestMusicItem(
                          currentIndex: index * 3,
                          snapshot: snapshot,
                        ),
                        NewestMusicItem(
                          currentIndex: index * 3 + 1,
                          snapshot: snapshot,
                        ),
                        NewestMusicItem(
                          currentIndex: index * 3 + 2,
                          snapshot: snapshot,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewestMusicItem extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int currentIndex;

  NewestMusicItem({
    Key key,
    @required this.snapshot,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentIndex > snapshot.data.length - 1
        ? Container(
            padding: EdgeInsets.only(bottom: 14.0),
            child: Text(''),
          )
        : Container(
            padding: EdgeInsets.only(right: 20.0, top: 7.0, bottom: 7.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.1),
                  style: (currentIndex + 1) % 3 == 0 ||
                          currentIndex == snapshot.data.length - 1
                      ? BorderStyle.none
                      : BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(0, 0, 0, .4),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${snapshot.data[currentIndex]['picUrl']}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("${snapshot.data[currentIndex]['name']}"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          );
  }
}
