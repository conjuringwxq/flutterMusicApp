import 'package:flutter/material.dart';

class ModuleTitleBar extends StatelessWidget {
  final String title;
  final String trailingLabel;
  final IconData trailingIcon;
  final bool hideTrailingIcon;

  ModuleTitleBar({
    Key key,
    @required this.title,
    @required this.trailingLabel,
    this.trailingIcon,
    this.hideTrailingIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      trailing: Container(
        width: 110.0,
        height: 30.0,
        child: hideTrailingIcon == true
            ? OutlineButton(
                child: Text(trailingLabel),
                onPressed: () {},
                shape: StadiumBorder(),
                highlightedBorderColor: Color.fromRGBO(0, 0, 0, 0.1),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
              )
            : OutlineButton.icon(
                icon: Icon(
                  trailingIcon,
                  size: 14.0,
                ),
                label: Text(
                  trailingLabel,
                  style: TextStyle(fontSize: 14.0),
                ),
                onPressed: () {},
                shape: StadiumBorder(),
                highlightedBorderColor: Color.fromRGBO(0, 0, 0, 0.1),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
              ),
      ),
    );
  }
}
