import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Screens/CaseScreen/case_status_screen.dart';
import 'package:hck_case_management/Screens/CauselistScreen/CauseListPage.dart';
import 'package:hck_case_management/Screens/CheckSlipScreen/check_slip_screen.dart';
import 'package:hck_case_management/Screens/DailyOrdersView/DailyOrderPage.dart';
import 'package:hck_case_management/Screens/JudgmentScreen/JudgmetScreen.dart';
import 'package:hck_case_management/Screens/copy_status/copy_status.dart';
import 'package:hck_case_management/Screens/displayboard/DisplayBoard.dart';
import 'package:hck_case_management/Screens/my_cases/MyCases.dart';
import 'package:hck_case_management/Widgets/grid_main.dart';

import 'href.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void initState() {
    check().then((internet) {
      if (internet != null && internet) {

      } else {
        _showMyDialog();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("High Court of Karnataka"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("images/high_court.png", ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset("images/HCK.png",),
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   color: Colors.black.withOpacity(0.3),
          // ),


          SingleChildScrollView(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: GridMain(rep: Utils.getGrids(), onClicked: (val){
                    onClicked(val);
                  },),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  void onClicked(val) {
    switch(val){
      case 0:
        NavHistory.pushPage(context, CaseStatusScreen());
        break;
      case 1:

        NavHistory.pushPage(context, CauseListPage());
        //NavHistory.pushPage(context, CauselistView());
        break;

      case 2:
        NavHistory.pushPage(context, DisplayBoard());
        break;

      case 3:
        NavHistory.pushPage(context, CheckSlipScreen());
        break;

      case 4:
      NavHistory.pushPage(context, DailyOrderPage());
        break;

      case 5:
      NavHistory.pushPage(context, JudgmetScreen());
        break;

      case 6:
      NavHistory.pushPage(context, CopyingStatus());
        break;

      case 7:
      NavHistory.pushPage(context, Mycases());
        break;

      case 8:
      //NavHistory.pushPage(context, hreftest());
        break;

    }
  }
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('No Internet'),
                Text('App not able to access Internet'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
