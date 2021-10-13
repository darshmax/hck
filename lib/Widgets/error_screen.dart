import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:provider/provider.dart';


class ErrorScreen extends StatelessWidget{
  final String error;

  const ErrorScreen({Key key, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
            children: <Widget>[
              Container(
                // alignment: Alignment.center,
                color: Colors.white54,
              ),
              CupertinoAlertDialog(
                // title: Text(error,style: TextStyle(color: Colors.red),),
                content: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(error),
                ),
                actions: [
                  FlatButton(
                    textColor: Color(0xFF6200EE),
                    onPressed: () {
                      Provider.of<GlobalProvider>(context, listen: false).reset();
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            ]
        )
    );
  }

}