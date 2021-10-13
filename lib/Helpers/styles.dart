import 'package:flutter/material.dart';

class Style {

  static const LightBrown = Color(0xfff1efe5);
  static const LightGreen = Color(0xffE8FCD9);
  static const LightGrey = Color(0xfff2f2f2);

  static const AccentRed = Color(0xffDA6864);
  static const AccentGreen = Color(0xff55AB67);
  static const AccentBrown = Color(0xffE6E2D6);
  static const AccentBlue = Color(0xff5B75A6);
  static const AccentGrey = Color(0xff807970);

  static const DarkBrown = Color(0xff918E81);

  static const SelectedItemGrey = Color(0xffCCCFDC);
  static const SelectedItemBorderGrey = Color(0xffC5C5CF);

  static TextStyle labelTextStyle = TextStyle(color: Style.fromHex("#23527c"), fontSize: 15, fontWeight: FontWeight.bold);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}