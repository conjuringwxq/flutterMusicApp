import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/global_model.dart';
import 'models/find_model.dart';

import 'pages/tabBar/find.dart';
import 'pages/tabBar/video.dart';
import 'pages/tabBar/profile.dart';
import 'pages/tabBar/cloud.dart';
import 'pages/tabBar/account.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalModel()),
        ChangeNotifierProvider(create: (_) => FindModel()),
      ],
      child: MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '音乐',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Home(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  PageController _controller;

  _tabBarRouteView(int index) {
    switch (index) {
      case 1:
        return VideoScreen();
      case 2:
        return ProfileScreen();
      case 3:
        return CloudScreen();
      case 4:
        return AccountScreen();
      default:
        return FindScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    GlobalModel globalModel = context.watch<GlobalModel>();

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: globalModel.bottomBarSettingsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _tabBarRouteView(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        items: globalModel.bottomBarSettingsList.map(
          (BottomBarSettings item) {
            return BottomNavigationBarItem(
              title: Text(item.title),
              icon: Icon(item.icon),
            );
          },
        ).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          _controller.jumpToPage(index);
        },
      ),
    );
  }
}
