import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Screens/displayboard/error.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import 'dashboard.dart';

// https://karnatakajudiciary.kar.nic.in/api/benchname.php
//
// http://karnatakajudiciary.kar.nic.in/api/displayboard.php?bench=B

Future<List<Photo>> _func;
String url1 = "";
String benchname = "";

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse(url1));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

Future<String> fetchData() async {
  //final client=HttpClient();
  final response = await http.get(
      Uri.parse('http://karnatakajudiciary.kar.nic.in/api/displayboard.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return json.decode(response.body)["display_board"];
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  print(responseBody);
  var tagObjsJson = json.decode(responseBody)['display_board'];
  print("printing tagObj");
  print(tagObjsJson);
  // final parsed = json.decode(tagObjsJson.toString()).cast<Map<String, dynamic>>();
  // print("printing parsed");
  // print(parsed);

  return tagObjsJson.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String stage;
  final String hall_no;
  final String case_no;
  final String case_year;
  final String case_type;
  final String sl_no;
  final String cnt;

  const Photo({
    this.stage,
    this.hall_no,
    this.case_no,
    this.case_year,
    this.case_type,
    this.sl_no,
    this.cnt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        stage: json["stage"] == null ? "-" : json["stage"],
        hall_no: json["hall_no"] == null ? "-" : json["hall_no"],
        sl_no: json["sl_no"] == null ? "-" : json["sl_no"],
        case_no: json["case_no"] == null ? "-" : json["case_no"],
        case_year: json["case_year"] == null ? "-" : json["case_year"],
        case_type: json["case_type"] == null ? "-" : json["case_type"],
        cnt: json["cnt"] == null
            ? "No Sitting"
            : json["cnt"] == "0"
                ? "No Sitting"
                : json["cnt"]);
  }
}

class DisplayBoard extends StatefulWidget {
  static const String id = 'register';

  @override
  _DisplayBoardState createState() => _DisplayBoardState();
}

class _DisplayBoardState extends State<DisplayBoard> {
  UserApi u = new UserApi();

  final controller = ScrollController();
  double offset = 0;
  String benchName;
  Future<List<Photo>> _func;

  void initState() {
    check().then((internet) {
      if (internet != null && internet) {
        _getStateList();
        // _func = fetchPhotos(http.Client());
        // controller.addListener(onScroll);
      } else {
        _showMyDialog();
      }
    });
    super.initState();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Center(
              child: Text(
                "High Court Display Board",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.00, horizontal: 20.00),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: _myState,
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                    hint: Text('Select Bench'),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _myState = newValue;
                                        benchName = getName(_myState);
                                      });
                                    },
                                    items: statesList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['bench']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                        [],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print("Inside button");
                        print(_myState);
                        print(benchName);

                        if(_myState==null){
                          print("inside if");

                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => new ErrorPage()));

                        }
                        else{
                          setState(() {
                            url1 =
                            "http://karnatakajudiciary.kar.nic.in/api/displayboard.php?bench=${_myState}";
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      App(text: url1, name: benchName,code:_myState)));
                          print("Url " + url1);
                        }
                      },
                      child: Text('Go'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getName(String name) {
    if (name == 'B') {
      return "Bengaluru";
    }
    if (name == 'D') {
      return "Dharwad";
    }
    if (name == 'K') {
      return "Kalburgi";
    }
  }

  List statesList;
  String _myState;

  String stateInfoUrl =
      'https://karnatakajudiciary.kar.nic.in/api/benchname.php';

  Future<String> _getStateList() async {
    await http
        .get(
      Uri.parse(stateInfoUrl),
    )
        .then((response) {
      var data = json.decode(response.body);

      setState(() {
        statesList = data;
      });
    });
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
          title: Text('No Internet'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please check your connection'),
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

class MyHomePage extends State<DisplayBoard> {
  final controller = ScrollController();
  double offset = 0;
  Future<List<Photo>> _func;

  void initState() {
    _func = fetchPhotos(http.Client());
    controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Photo>>(
        future: _func,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //List?<Photo> data =snapshot.data;
            // print(data);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Display Board Lists ->',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortColumnIndex: 0,
                          sortAscending: true,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Hall No',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.0,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Hall No",
                            ),
                            DataColumn(
                              label: Text(
                                'SL NO',
                                style: TextStyle(
                                  color: Colors.orange.shade900,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Serial Number",
                            ),
                            DataColumn(
                              label: Text(
                                'Case No',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Number of Cases",
                            ),
                            DataColumn(
                              label: Text(
                                'Stage',
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Stage",
                            ),
                          ],
                          rows: snapshot.data
                              .map(
                                (country) => DataRow(
                                  cells: [
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Text(
                                          country.hall_no,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        width: 60.0,
                                        child: Center(
                                          child: Text(
                                            country.sl_no.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.cnt.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          country.stage,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 500),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                'An Error Occured!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "${snapshot.error}",
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
            );
          }
          // By default, show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('This may take some time..')
              ],
            ),
          );
        },
      ),
    );
  }
}

waitingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new Center(
        child: new SizedBox(
          width: 40.0,
          height: 40.0,
          child: const CircularProgressIndicator(
            value: null,
            strokeWidth: 2.0,
          ),
        ),
      );
    },
  );
}

Widget showData() {
  return new FutureBuilder<List<Photo>>(
    future: _func,
    builder: (context, snapshot) {
      print('In Builder');

      if (snapshot.hasData) {
        //List?<Photo> data =snapshot.data;
        // print(data);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Display Board Lists ',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: [
                        DataColumn(
                          label: Text(
                            'Hall No',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                          numeric: false,
                          tooltip: "Hall No",
                        ),
                        DataColumn(
                          label: Text(
                            'SL NO',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontSize: 14.0,
                            ),
                          ),
                          numeric: true,
                          tooltip: "Serial Number",
                        ),
                        DataColumn(
                          label: Text(
                            'Case No',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                          numeric: true,
                          tooltip: "Number of Cases",
                        ),
                        DataColumn(
                          label: Text(
                            'Stage',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 14.0,
                            ),
                          ),
                          numeric: true,
                          tooltip: "Stage",
                        ),
                      ],
                      rows: snapshot.data
                          .map(
                            (country) => DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width: 20,
                                    child: Text(
                                      country.hall_no,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 20,
                                    child: Center(
                                      child: Text(
                                        country.sl_no.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        country.cnt.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 20,
                                    child: Center(
                                      child: Text(
                                        country.stage,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),

              // SizedBox(height: 500),
            ],
          ),
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Select the Bench'),
            ],
          ),
        );
      }
      // By default, show a loading spinner.
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('This may take some time..')
          ],
        ),
      );
    },
  );
}

class UserApi {
  List<BenchJson> users = [];

  Future<List<BenchJson>> _getStateList() async {
    await http
        .get(
      Uri.parse("https://karnatakajudiciary.kar.nic.in/api/benchname.php"),
    )
        .then((response) {
      var data = json.decode(response.body);

      users.clear();
      for (var u in data) {
        BenchJson user = BenchJson(u["id"], u["bench"]);

        users.add(user);
      }
    });
    return users;
  }
}

class BenchJson {
  final String id;
  final String bench;

  BenchJson(this.id, this.bench);
}
