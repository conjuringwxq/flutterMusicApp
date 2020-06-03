import 'package:flutter/material.dart';
import 'package:music_app/notifiers/find_notifier.dart';

class EntranceScrollView extends StatelessWidget {
  final FindNotifier notifier;

  const EntranceScrollView({Key key, this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: notifier.entranceSettingsList.map((EntranceSettings item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 13.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Image.asset(
                  item.imageUrl,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                item.title,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
