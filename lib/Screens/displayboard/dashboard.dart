import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dashboard_result.dart';

String bench;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client

      //.get(Uri.parse('http://karnatakajudiciary.kar.nic.in/api/displayboard.php'));
      // .get(Uri.parse(' http://karnatakajudiciary.kar.nic.in/api/displayboard.php?bench=$bench'));
      .get(Uri.parse(bench));
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
        stage: json["stage"] == null ? " " : json["stage"],
        hall_no: json["hall_no"] == null ? " " : json["hall_no"],
        sl_no: json["sl_no"] == null ? " " : json["sl_no"],
        case_no: json["case_no"] == null ? " " : json["case_no"],
        case_year: json["case_year"] == null ? " " : json["case_year"],
        case_type: json["case_type"] == null ? " " : json["case_type"],
        cnt: json["cnt"] == null
            ? "No Sitting"
            : json["cnt"] == "0"
                ? "No Sitting"
                : json["cnt"]
        // hall_no: json['hall_no'] as String,
        // case_no: json['case_no'] as String,
        // case_year: json['case_year'] as String,
        // case_type: json['case_type'] as String,
        // sl_no: json['sl_no'] as String,
        // cnt: json['cnt'] as String,
        );
  }
}

class App extends StatefulWidget {
  final String text;
  final String name;
final String code;

  const App({Key key, @required this.text, @required this.name,@required this.code})
      : super(key: key);

  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<App> {
  final controller = ScrollController();
  double offset = 0;
  Future<List<Photo>> _func;
  Color color;
  String hallno;
  String url1;
  int selectedIndex = -1;

  void initState() {
    print(widget.text);
    bench = widget.text.toString();
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

  // setState(() {
  // const oneSecond = const Duration(seconds: 25);
  // new Timer.periodic(oneSecond, (Timer t) => buildCountWidget());
  // });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Center(
                child: Text(
                  widget.name + '  High Court Display Board',
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
            body: _pageRefresh(),
          ),
        ));
  }

  Widget _pageRefresh() {
    Widget Data = new FutureBuilder<List<Photo>>(
      future: _func,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          new Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: CircularProgressIndicator(),
          );
          //List?<Photo> data =snapshot.data;
          // print(data);
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(1.2),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showCheckboxColumn: false,
                          sortColumnIndex: 0,
                          sortAscending: true,
                          columns: [
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Hall No',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              numeric: false,
                              tooltip: "Hall No",
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'SL NO',
                                  style: TextStyle(
                                    color: Colors.orange.shade900,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              numeric: true,
                              tooltip: "Serial Number",
                            ),

                            DataColumn(
                              label: Container(
                                width: 140,
                                child: Center(
                                  child: Text(
                                    'Case No',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              numeric: true,
                              tooltip: "Number of Cases",
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Stage',
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              numeric: true,
                              tooltip: "Stage",
                            ),
                          ],
                          rows: snapshot.data
                              .map(
                                (country) => DataRow(
                                  selected: snapshot.data.indexOf(country) ==
                                      selectedIndex,
                                  onSelectChanged: (bool selected) {
                                    if (selected) {
                                      setState(() {
                                        hallno = country.hall_no;
                                        selectedIndex =
                                            snapshot.data.indexOf(country);
                                        print(snapshot.data.indexOf(country));
                                        url1 =
                                            "https://karnatakajudiciary.kar.nic.in/api/passedover.php?bench=" +
                                                widget.code +
                                                "&hall_no=" +
                                                hallno;
                                      });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DashPopupResult(text: url1)));
                                    }
                                  },
                                  cells: [
                                    DataCell(
                                      Container(
                                        width: 30,
                                        child: Center(
                                          child: Text(
                                            country.hall_no,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        width: 30.0,
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
                                      country.case_type == " " ? Center(child: new Text("No Sitting",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),)) :  Container(
                                        child: Center(
                                          child: new
                                                  Text(
                                                country.case_type+"-"+country.case_no+"/"+country.case_year,

                                                //country.case_type+"-"+country.case_no+"/"+country.case_year,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600),
                                              ),
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
    );
    return Data;
  }
}
