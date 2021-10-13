import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      body: AlertDialog(
      title: Text(
        'Alert',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
      content: Text(
        "Please Select the Bench",
        style: TextStyle(
          color: Colors.blueAccent,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Go Back',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
        ),
    );
  }
}
