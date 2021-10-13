import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Providers/login_provider.dart';
import 'package:hck_case_management/Widgets/input_text.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:hck_case_management/main.dart';
import 'package:provider/provider.dart';

class MainLogin extends StatefulWidget {
  @override
  State<MainLogin> createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {

  void initState() {
    check().then((internet) {
      if (internet != null && internet) {

      } else {
        _showMyDialog();
      }
    });
    super.initState();
  }

  final TextEditingController mUserName = TextEditingController(),
      mPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Presidency"),
      // ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("images/high_court.png", fit: BoxFit.cover,
                        height: 100,),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(" High Court of karnataka",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 40,),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                      //   child: Align(alignment: Alignment.topLeft, child: Text("Login", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                      // ),
                      SizedBox(height: 6,),
                      InputText(isPassword: false,
                        title: "Username",
                        icon: Icons.person,
                        mCtrl: mUserName,),
                      SizedBox(height: 15,),
                      InputText(isPassword: false,
                        title: "Phone",
                        icon: Icons.phone,
                        mCtrl: mPhone,
                        maxLength: 10,),
                      SizedBox(height: 18,),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: Utils.btnGradient
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 7),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)
                              )
                          ),

                          child: new Text('Click to Continue', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          onPressed: () {
                            onLoginClicked(context);
                          },
                        ),
                      ),

                      SizedBox(height: 60,),
                    ],
                  ),
                )
            ),
            Consumer<GlobalProvider>(builder: (context, global, child) {
              print(global.error);
              return LoadingScreen(
                isBusy: global.isBusy, error: global?.error,);
            })
          ],
        )
    );
  }

  void onLoginClicked(BuildContext context) async {
    //print(mPhone.text.length);
    if (mUserName.text == '' || mUserName.text == null) {
      Provider.of<GlobalProvider>(context, listen: false).setIsBusy(
          false, "Enter User Name");
    }
    else if (mPhone.text.length != 10) {
      Provider.of<GlobalProvider>(context, listen: false).setIsBusy(
          false, "Enter Valid Mobile Number");
    }
    else {
      Provider.of<LoginProvider>(context, listen: false).onLoginClicked(
          mUserName.text, mPhone.text, context);
    }
    // }

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
