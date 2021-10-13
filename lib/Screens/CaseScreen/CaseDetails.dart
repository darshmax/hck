import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Models/case_info.dart';
import 'package:http/http.dart' as http;



class CaseDetails extends StatefulWidget {
  final List<Case_details> caseDetails;

  const CaseDetails({Key key, this.caseDetails}) : super(key: key);

  @override
  FullCaseDetails createState() => FullCaseDetails();
}

class FullCaseDetails extends State<CaseDetails>{

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Case Status'),
      ),

      body:  ListView(

          children: <Widget>[
            SizedBox(height: 15,),
            // Center(
            //     child: Text(
            //
            //       'Status : '+widget.caseDetails[0].status,
            //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.redAccent),
            //     )),
            Center(

              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlue[800],
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 50),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)
                    )
                ),

                child: new Text('Status : '+widget.caseDetails[0].status, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),

              ),
            ),
            SizedBox(height: 15,),
            DataTable(
                columnSpacing: 10,
              dataRowHeight: 90,
              headingRowHeight: 90,

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
                DataColumn(label: Text(widget.caseDetails[0].filType+" "+widget.caseDetails[0].filNo+"/"+widget.caseDetails[0].filYear,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),

              ],
              rows: [
                DataRow(

                    cells: [
                  DataCell(Text('Cino',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].cino,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Case No',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].caseType+" "+widget.caseDetails[0].caseNo+"/"+widget.caseDetails[0].caseYear,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Petitioner',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].petitioner,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Respondent',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].respondent,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Action Taken',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].orderName,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Date of Action',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].dateAction,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Classification',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].subType+" "+widget.caseDetails[0].subSubType,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Posted For',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].purposeName,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Next Date',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].dateNextList,style: TextStyle(fontSize: 18,),)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Before Honble Judges',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.caseDetails[0].judge,style: TextStyle(fontSize: 18,),)),
                ]),
              ],
            ),
          ]),


    );
  }


}