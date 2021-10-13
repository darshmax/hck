

import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  bool _isBusy = false;
  String _error;

  bool get isBusy => _isBusy;
  String get error => _error;

  GlobalProvider(){
    // setIsBusy(false);
  }

  setIsBusy(bool val, String error){
    _isBusy = val;
    _error = error;
    print(val);
    refresh();
  }

  refresh(){
    try{
      Future.delayed(Duration.zero, () async {
        notifyListeners();
      });

    }catch(e){

    }
  }

  reset(){
    _isBusy = false;
    _error = null;
    refresh();
  }

}