import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PassedData {
  String listNo;
  String slNo;
  String hallNo;
  String caseType;
  String caseNo;
  String caseYear;
  String causelistDate;

  PassedData(
      {this.listNo,
      this.slNo,
      this.hallNo,
      this.caseType,
      this.caseNo,
      this.caseYear,
      this.causelistDate});
}

class DashPopupResult extends StatefulWidget {
  final String text;
  final String listNo = "";
  final String slNo = "";

  final String hallNo = "";
  final String caseType = "";

  final String caseNo = "";

  final String caseYear = "";
  final String causelistDate = "";

  const DashPopupResult({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  _DashPopupResultState createState() => _DashPopupResultState();
}

class _DashPopupResultState extends State<DashPopupResult> {
  int selectedIndex = -1;
  var responseData;
  var data;

  Future<List<PassedData>> getRequest() async {
    //replace your restFull API here.
    String url1 = widget.text;
    await http
        .get(
      Uri.parse(url1),
    )
        .then((response) {
      print(url1);
      print("inside response");
      responseData = json.decode(response.body);
      print(responseData);
      data = responseData["passed_data"];
      print(data);
    });

    List<PassedData> users = [];
    for (var json in data) {
      PassedData user = PassedData(
          listNo: json['list_no'],
          slNo: json['sl_no'],
          hallNo: json['hall_no'],
          caseType: json['case_type'],
          caseNo: json['case_no'],
          caseYear: json['case_year'],
          causelistDate: json['causelist_date']);

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

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
                "Passed Over List",
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
          body: Container(
              child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<PassedData>>(
                  future: getRequest(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
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
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'List No',

                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 22.0,
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
                                              fontSize: 22.0,
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Serial Number",
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Hall No',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Number of Cases",
                                        ),
                                        // DataColumn(
                                        //   label: Text(
                                        //     'Case Type',
                                        //     style: TextStyle(
                                        //       color: Colors.red.shade700,
                                        //       fontSize: 16.0,
                                        //     ),
                                        //   ),
                                        //   numeric: true,
                                        //   tooltip: "Stage",
                                        // ),
                                        DataColumn(
                                          label: Container(
                                            width: 160,
                                            child: Center(
                                              child: Text(
                                                'Case No',
                                                style: TextStyle(
                                                  color: Colors.red.shade700,
                                                  fontSize: 22.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Stage",
                                        ),
                                        // DataColumn(
                                        //   label: Text(
                                        //     'Case Year',
                                        //     style: TextStyle(
                                        //       color: Colors.red.shade700,
                                        //       fontSize: 16.0,
                                        //     ),
                                        //   ),
                                        //   numeric: true,
                                        //   tooltip: "Stage",
                                        // ),
                                        DataColumn(
                                          label: Text(
                                            'Causelist Date',
                                            style: TextStyle(
                                              color: Colors.red.shade700,
                                              fontSize: 22.0,
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
                                                    width: 60,
                                                    child: Center(
                                                      child: Text(
                                                        country.listNo,
                                                        softWrap: true,
                                                        textAlign: TextAlign.left,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    width: 50.0,
                                                    child: Center(
                                                      child: Text(
                                                        country.slNo,

                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    width: 50.0,
                                                    child: Center(
                                                      child: Text(
                                                        country.hallNo,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // DataCell(
                                                //   Center(
                                                //     child: Text(
                                                //       country.caseType,
                                                //       style: TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold),
                                                //     ),
                                                //   ),
                                                // ),
                                                DataCell(
                                                  Container(
                                                    width: 160.0,
                                                    child: Center(
                                                      child: Text(

                                                        country.caseType +
                                                            "-" +
                                                            country.caseNo +
                                                            "/" +
                                                            country.caseYear,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                        fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // DataCell(
                                                //   Center(
                                                //     child: Text(
                                                //       country.caseYear,
                                                //       style: TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold),
                                                //     ),
                                                //   ),
                                                // ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      country.causelistDate,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
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
                      return Container(
                        child: Text("No Passed Over Cases"),
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
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(child: const Text('Back')),
              ),
            ],
          )),
        ),
      ),
    );
  }

  showMyDialog() {
    return showDialog<Widget>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
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
