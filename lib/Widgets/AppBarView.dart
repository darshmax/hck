import 'package:flutter/material.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget{
  final Color backgroundColor = Colors.blue;
  final Text title;
  final AppBar appBar;
  const AppBarView({Key key, this.title, this.appBar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: new Center(child: title,),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

}