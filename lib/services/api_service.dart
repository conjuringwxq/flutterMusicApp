class ApiBase {
  String get baseUrl => 'http://localhost:3000';
}

class ApiService extends ApiBase {
  // 轮播图 banner
  String get banner => super.baseUrl + '/banner';

  // 推荐歌单
  String get personalized => super.baseUrl + '/personalized';

  // 推荐新音乐
  String get newSong => super.baseUrl + '/personalized/newsong';

  // 音乐排行榜
  String get rankingList => super.baseUrl + '/top/list';
}
