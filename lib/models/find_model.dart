class BannerModel {
  final String pic;
  final String titleColor;
  final String typeTitle;

  BannerModel({this.pic, this.titleColor, this.typeTitle});

  BannerModel.fromJson(Map<String, dynamic> json)
      : pic = json['pic'],
        titleColor = json['titleColor'],
        typeTitle = json['typeTitle'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pic'] = this.pic;
    data['titleColor'] = this.titleColor;
    data['typeTitle'] = this.typeTitle;
    return data;
  }
}

class RankingListModel {
  String picUrl;
  String title;
  String name;
  String author;

  RankingListModel(
    Map item, {
    this.picUrl,
    this.title,
    this.name,
    this.author,
  });

  RankingListModel.fromJson(Map json, [int order]) {
    if (order == null) {
      this.title = json['playlist']['name'];
      return;
    }
    this.picUrl = json['playlist']['tracks'][order]['al']['picUrl'];
    this.name = json['playlist']['tracks'][order]['name'];
    this.author = json['playlist']['tracks'][order]['ar'][0]['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picUrl'] = this.picUrl;
    data['title'] = this.title;
    data['name'] = this.name;
    data['author'] = this.author;
    return data;
  }
}
