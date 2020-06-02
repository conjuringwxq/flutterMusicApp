import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:music_app/models/find_model.dart';

class BannerSwiper extends StatelessWidget {
  final FindModel model;

  const BannerSwiper({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 150.0,
      child: FutureBuilder(
        future: model.getBanner(),
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
                        "${snapshot.data[index]['pic']}",
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 1.0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: snapshot.data[index]['titleColor'] == "red"
                                ? Colors.red
                                : Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "${snapshot.data[index]['typeTitle']}",
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
