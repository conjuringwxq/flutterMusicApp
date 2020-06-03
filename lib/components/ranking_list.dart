import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:music_app/notifiers/find_notifier.dart';
import 'package:music_app/models/find_model.dart';

import 'module_title_bar.dart';

class RankingList extends StatefulWidget {
  final FindNotifier notifier;

  RankingList({Key key, this.notifier}) : super(key: key);

  @override
  _RankingListState createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  PageController controller = new PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ModuleTitleBar(
          title: "热歌风向标",
          trailingLabel: "查看更多",
          hideTrailingIcon: true,
        ),
        Container(
          height: 250.0,
          child: FutureBuilder(
            future: widget.notifier.getRankingList([23, 2, 3, 4, 5]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CupertinoActivityIndicator(radius: 16.0);
              }

              return PageView.builder(
                controller: controller,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  Map rangkingJson = snapshot.data.toList()[index];
                  return Container(
                    margin: EdgeInsets.only(right: 15.0),
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          RankingListModel.fromJson(rangkingJson, 0).picUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Opacity(
                          opacity: 1.0,
                          child: RankingTitle(
                            title:
                                RankingListModel.fromJson(rangkingJson).title,
                            leading: Icons.adb,
                          ),
                        ),
                        Opacity(
                          opacity: 1.0,
                          child: Container(
                            child: Column(
                              children: [0, 1, 2].map((int order) {
                                RankingListModel rankingListModel =
                                    RankingListModel.fromJson(
                                        rangkingJson, order);
                                return RankingItem(
                                  image: Image.network(
                                    rankingListModel.picUrl,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  order: order + 1,
                                  name: rankingListModel.name,
                                  author: rankingListModel.author,
                                  flag: "新",
                                );
                              }).toList(),
                            ),
                          ),
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

class RankingTitle extends StatelessWidget {
  final String title;
  final IconData leading;
  final Color color;

  RankingTitle({
    Key key,
    @required this.title,
    this.leading,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (leading == null) {
      return Row(
        children: <Widget>[
          Text(title, style: TextStyle(color: color)),
          Icon(Icons.keyboard_arrow_right, color: color),
        ],
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 10.0),
      child: Row(
        children: <Widget>[
          Icon(leading, color: color),
          Text(title, style: TextStyle(color: color, fontSize: 18.0)),
          Icon(Icons.keyboard_arrow_right, color: color),
        ],
      ),
    );
  }
}

class RankingItem extends StatelessWidget {
  final Image image;
  final int order;
  final String name;
  final String author;
  final String flag;

  RankingItem({
    Key key,
    @required this.image,
    @required this.order,
    @required this.name,
    @required this.author,
    @required this.flag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
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
          child: image,
        ),
      ),
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Text(
              "$order",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$name",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "- $author",
              style: TextStyle(fontSize: 14.0, color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      trailing: Text("$flag", style: TextStyle(color: Colors.white)),
    );
  }
}
