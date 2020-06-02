import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/services/api_service.dart';

class EntranceSettings {
  final String imageUrl;
  final String title;

  EntranceSettings({this.imageUrl, this.title});
}

class FindModel with ChangeNotifier {
  Response response;

  Dio dio = new Dio();

  ApiService apiService = new ApiService();

  static const Map<String, List<Map<String, String>>> settings = {
    "value": [
      {"imageUrl": "images/find_every_day.png", "title": "每日推荐"},
      {"imageUrl": "images/find_playlist.png", "title": "歌单"},
      {"imageUrl": "images/find_rank.png", "title": "排行榜"},
      {"imageUrl": "images/find_radio.png", "title": "电台"},
      {"imageUrl": "images/find_live.png", "title": "直播"},
      {"imageUrl": "images/find_live.png", "title": "直播"},
    ]
  };

  static final List<EntranceSettings> _entranceSettingsList = settings["value"]
      .map(
        (Map<String, String> item) => EntranceSettings(
          imageUrl: item["imageUrl"],
          title: item["title"],
        ),
      )
      .toList();

  List<EntranceSettings> get entranceSettingsList => _entranceSettingsList;

  Future<List> getBanner() async {
    int type;
    if (Platform.isAndroid == true) {
      type = 1;
    }
    if (Platform.isIOS == true) {
      type = 2;
    }
    Response response = await dio.get(
      apiService.banner,
      queryParameters: {"type": type},
    );
    return json.decode(response.toString())['banners'];
  }

  Future<List> getPersonalized({int limit = 6}) async {
    Response response = await dio.get(
      apiService.personalized,
      queryParameters: {"limit": limit},
    );
    return json.decode(response.toString())['result'];
  }

  Future<List> getNewSong() async {
    Response response = await dio.get(apiService.newSong);
    return json.decode(response.toString())['result'];
  }

  Future<Iterable<Map<String, dynamic>>> getRankingList(List<int> ids) async {
    List<Response> responseList = await Future.wait(
      ids.map(
        (int idx) => dio.get(
          apiService.rankingList,
          queryParameters: {"idx": idx},
        ),
      ),
    );

    return responseList.map(
      (Response response) => {
        "playlist": json.decode(response.toString())["playlist"],
        "privileges": json.decode(response.toString())["privileges"],
      },
    );
  }
}
