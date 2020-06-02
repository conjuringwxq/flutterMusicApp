import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({ Key key }): super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          IconData(0xe6ef, fontFamily: 'iconfont'),
          color: Colors.black,
        ),
        onPressed: () {
          print('听歌识曲');
        },
      ),
      title: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xffeeeeee),
        ),
        child: CustomSearchInput(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.block, color: Colors.black),
          onPressed: () {
            print('查看更多');
          },
        ),
      ],
    );
  }
}

class CustomSearchInput extends StatefulWidget {
  @override
  _CustomSearchInputState createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      print(_textEditingController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _textEditingController,
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
      ),
      placeholder: '轮回之境 - CRITTY',
      textAlign: TextAlign.left,
      placeholderStyle: TextStyle(color: Color(0xffc7c7c7)),
      prefix: Icon(
        IconData(0xe65c, fontFamily: 'iconfont'),
        color: Colors.grey[800],
        size: 16.0,
      ),
    );
  }
}
