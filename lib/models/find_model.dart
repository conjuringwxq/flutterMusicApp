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
  final String picUrl;
  final String title;
  final String name;
  final List<String> author;

  RankingListModel({
    this.picUrl,
    this.title,
    this.name,
    this.author,
  });

  // RankingListModel.fromJson(Map json);
}
