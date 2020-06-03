import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:music_app/notifiers/find_notifier.dart';
import 'package:music_app/models/find_model.dart';

class BannerSwiper extends StatelessWidget {
  final FindNotifier notifier;

  const BannerSwiper({Key key, this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 150.0,
      child: FutureBuilder(
        future: notifier.getBanner(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CupertinoActivityIndicator(
              radius: 16.0,
            );
          }
          return Swiper(
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red,
                color: Colors.grey[400],
              ),
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        "${BannerModel.fromJson(snapshot.data[index]).pic}",
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 1.0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: BannerModel.fromJson(snapshot.data[index])
                                        .titleColor ==
                                    "red"
                                ? Colors.red
                                : Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "${BannerModel.fromJson(snapshot.data[index]).typeTitle}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data.length,
            autoplay: true,
          );
        },
      ),
    );
  }
}
