import 'package:flutter/cupertino.dart';

class BottomBarSettings {
  final IconData icon;
  final String title;

  BottomBarSettings({this.icon, this.title});
}

class GlobalModel with ChangeNotifier {
  final List<BottomBarSettings> _bottomBarSettingsList = [
    BottomBarSettings(
      icon: IconData(0xe601, fontFamily: 'iconfont'),
      title: '发现',
    ),
    BottomBarSettings(
      icon: IconData(0xe880, fontFamily: 'iconfont'),
      title: '视频',
    ),
    BottomBarSettings(
      icon: IconData(0xe795, fontFamily: 'iconfont'),
      title: '我的',
    ),
    BottomBarSettings(
      icon: IconData(0xe818, fontFamily: 'iconfont'),
      title: '云村',
    ),
    BottomBarSettings(
      icon: IconData(0xe736, fontFamily: 'iconfont'),
      title: '账号',
    ),
  ];
  List<BottomBarSettings> get bottomBarSettingsList => _bottomBarSettingsList;
}
