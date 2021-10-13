import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Models/grid_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static const Color scaffold = Color(0xFFF0F2F5);
  static const double padding = 20;
  static const double avatarRadius = 45;
  static const Color facebookBlue = Color(0xFF1777F2);
  static Color peach = fromHex("#F67B5A");
  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black87],
  );


  static  LinearGradient btnGradient = LinearGradient(
    begin: Alignment(-1.0, -4.0),
    end: Alignment(1.0, 4.0),
    colors: [fromHex("#FFA81D"), fromHex("#F45C43")],
  );

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static List<GridModel> getGrids(){
    List<GridModel> grid = [
      new GridModel(title: "Case Status", des: "Detailed Case Status", image: "images/icon_caseStatus.png"),
      new GridModel(title: "Cause List", des: "", image: "images/icon_causelist.png"),
      new GridModel(title: "Dispaly Board", des: "", image: "images/displayIcon.png"),
      new GridModel(title: "Office Objection", des: "", image: "images/objectionIcon.png"),
      new GridModel(title: "Daily Order", des: "", image: "images/orderIcon.png"),
      new GridModel(title: "Judgement", des: "", image: "images/icon_judgments.png"),
      new GridModel(title: "Certified Copy", des: "", image: "images/icon_certCopy.png"),
      new GridModel(title: "My Cases", des: "", image: "images/myCasesIcon.png"),
      //new GridModel(title: "Test", des: "", image: "images/high_court.png"),



    ];
    return grid;
  }

  static launchUrl(String url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static List<String> getYearList(){
    List<String> yearsList = [];
    String currentYear = DateFormat('yyyy').format(DateTime.now());
    int maxYear = int.parse(currentYear);
    final minimumYear = 1990;
    for(int i = minimumYear; i <= maxYear; i++){
      yearsList.add(i.toString());
    }
    return yearsList.reversed.toList();
  }
}