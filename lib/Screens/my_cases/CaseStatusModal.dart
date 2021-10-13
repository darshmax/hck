import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  String caseType;
  String subType;
  String subSubType;
  String caseNo;
  String caseYear;
  String cino;
  String petitioner;
  String respondent;
  String courtNo;
  String judge;
  String petitionerAdvocate;
  String respondentAdvocate;
  String status;
  String filingDate;
  String decisionDate;
  String dateNextList;
  String tentativeDate;
  String purposeNext;
  String purposeName;
  String causelistType;
  String shortOrder;
  String orderName;
  String dateAction;
  String defective;
  String dispNature;
  String disposalType;
  String filType;
  String filNo;
  String filYear;

  User(
      {
        this.caseType,
        this.subType,
        this.subSubType,
        this.caseNo,
        this.caseYear,
        this.cino,
        this.petitioner,
        this.respondent,
        this.courtNo,
        this.judge,
        this.petitionerAdvocate,
        this.respondentAdvocate,
        this.status,
        this.filingDate,
        this.decisionDate,
        this.dateNextList,
        this.tentativeDate,
        this.purposeNext,
        this.purposeName,
        this.causelistType,
        this.shortOrder,
        this.orderName,
        this.dateAction,
        this.defective,
        this.dispNature,
        this.disposalType,
        this.filType,
        this.filNo,
        this.filYear,
      }
      );
}

class CasesPopupResult extends StatefulWidget {
  final String text;

  const CasesPopupResult({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  _PopupResultState createState() => _PopupResultState();
}

class _PopupResultState extends State<CasesPopupResult> {
  var responseData;
  var data;

  Future<List<User>> getRequest() async {
    //replace your restFull API here.
    String url1 = widget.text;
    print(url1);
    await http
        .get(
      Uri.parse(url1),
    )
        .then((response) {
      print(url1);
      print("inside response");
      responseData = json.decode(response.body);
      print(responseData);
      data = responseData["case_details"];
      print(data);
    });

    List<User> users = [];
    for (var json in data) {
      User user = User(
          caseType : json['case_type'],
          caseNo : json['case_no'],
          caseYear : json['case_year'],
          subType : json['sub_type'],
          subSubType : json['sub_sub_type'],
          cino : json['cino'],
          petitioner : json['petitioner'],
          respondent : json['respondent'],
          courtNo : json['court_no'],
          judge : json['judge'],
          petitionerAdvocate : json['petitioner_advocate'],
          respondentAdvocate : json['respondent_advocate'],
          status : json['status'],
          filingDate : json['filing_date'],
          decisionDate : json['decision_date'],
          dateNextList : json['date_next_list'],
          tentativeDate : json['tentative_date'],
          purposeNext : json['purpose_next'],
          purposeName : json['purpose_name'],
          causelistType : json['causelist_type'],
          shortOrder : json['short_order'],
          orderName : json['order_name'],
          dateAction : json['date_action'],
          defective : json['defective'],
          dispNature : json['disp_nature'],
          disposalType : json['disposal_type'],
          filType : json['fil_type'],
          filNo : json['fil_no'],
          filYear : json['fil_year']
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(),
          ),
          color: Colors.blueAccent,
        ),
        content: setupAlertDialoadContainer(context),
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]
    );
  }

  Widget setupAlertDialoadContainer(context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(child: Text('Case Status',style: TextStyle(fontSize: 18.00,color: Colors.red,fontWeight: FontWeight.bold),)),
                        SizedBox(height: 20),
                        Container(height: 2, color: Colors.redAccent),
                        SizedBox(height: 40),
                        Center(child: Text('No Data found',style: TextStyle(fontSize: 14.00,fontWeight: FontWeight.bold),)),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else {
                return ListView(children: <Widget>[
                Center(

                child: TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlue[800],
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)
                    )
                ),

              child: new Text('Status : '+snapshot.data[0].status, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),

              ),
              ),

              SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12,
                dataRowHeight: 90,
                headingRowHeight: 90,
                horizontalMargin: 12,

                dividerThickness: 5,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300],width: 5)
                ),
                columns: [

                  DataColumn(

                      label: Text(
                          'FR No',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      )),
                  DataColumn(label: Text(snapshot.data[0].filType+" "+snapshot.data[0].filNo+"/"+snapshot.data[0].filYear,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  )),

                ],
                rows: [
                  DataRow(

                      cells: [
                        DataCell(Text('Cino',style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold
                        ),)),
                        DataCell(Text(snapshot.data[0].cino,style: TextStyle(fontSize: 18,),)),
                      ]),

                  DataRow(cells: [
                    DataCell(Text('Case No',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].caseType+" "+snapshot.data[0].caseNo+"/"+snapshot.data[0].caseYear,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Petitioner',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].petitioner,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Respondent',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].respondent,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Action Taken',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].orderName,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Date of Action',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].dateAction,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Classification',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].subType+" "+snapshot.data[0].subSubType,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Posted For',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].purposeName,style: TextStyle(fontSize: 18,),)),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Next Date',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].dateNextList,style: TextStyle(fontSize: 18,),)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Before Honble Judges',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
                    DataCell(Text(snapshot.data[0].judge,style: TextStyle(fontSize: 18,),)),
                  ]),
                ],
              ),
              ),),

                ]);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String name, String score) {
    return Padding(
      padding: const EdgeInsets.all(1),

      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[

              SizedBox(width:4),
              Text(name),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child:
                Text('$score',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }

}
