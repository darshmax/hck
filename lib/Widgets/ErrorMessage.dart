
import 'package:flutter/material.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:provider/provider.dart';
class ErrorMessage{
  //final String errormsg;

  //ErrorMessage(this.errormsg);
  //Provider.of<GlobalProvider>(context, listen: false).setIsBusy(
  //             false, caseList.msg);
  //       }

  errorStatus(String errormsg){
    BuildContext context;
    print("dfzsD");
    return Provider.of<GlobalProvider>(context, listen: false).setIsBusy(
        false, errormsg);
  }
  }

