

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/api_base.dart';
import 'package:hck_case_management/Helpers/constants.dart';
import 'package:hck_case_management/Models/case_info.dart';
import 'package:hck_case_management/Models/login_status.dart';
import 'package:hck_case_management/Screens/HomeScreen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hck_case_management/Apis/api_response.dart';
import 'package:hck_case_management/Apis/http_response.dart';
import 'package:http/http.dart' as http;

import 'global_provider.dart';

class LoginProvider with ChangeNotifier {
  SharedPreferences prefs;
  LoginStatus _mainUser;

  LoginStatus get mainUser => _mainUser;

  LoginProvider(){
    refresh();
  }

  fetchFromSharedPreference()async{
    prefs = await SharedPreferences.getInstance();
    String userValues = prefs.getString('loginUser') ?? "";
    _mainUser = LoginStatus.fromJson(json.decode(userValues));
    if(userValues != ""){
      notifyListeners();
    }
  }

  onLoginClicked(String userName, String ph, BuildContext context) async{
      // call login api here
    String now = DateTime.now().toString();
    //print(now);
    var url = "registeredUserInfo.php";
    var bodydata=jsonEncode(<String, String>{
      'username': userName,
      'datetime': now,
      'mobilenum': ph,
    });
    print( url);
    CustomResponse response = await HttpClientRequest.instance.fetchData(context,  url,bodydata );
    print(response);
    if(response.Status==1){
      final val = json.decode(response.Data);
      LoginStatus userstatus = LoginStatus.fromJson(val);
      print(userstatus.status.status.toString() + ":" + userstatus.status.msg);
      if(userstatus.status.status==1)
        {
          prefs = await SharedPreferences.getInstance();
          prefs.setString('loginUser', jsonEncode(val));
          prefs.setString("Mobile_NUMBER", ph);

          _mainUser = userstatus;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);
        }
      else{
        Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, "Registration Failed");
      }
    }
    else{
      Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, "Registration Failed");
    }

    notifyListeners();
  }

  // saveToSharedPreference() async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setString(loginUser, jsonEncode(""));
  // }


  refresh()async{
    prefs = await SharedPreferences.getInstance();
  }





}


