
import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/judgement_model.dart';
import 'package:hck_case_management/Models/my_cause_list.dart';

class MyCauseListDetails extends StatefulWidget {
  final List<Details> causeDetails;
  const MyCauseListDetails({Key key, this.causeDetails}) : super(key: key);
  @override
  MyCauseListDetailsState createState() => MyCauseListDetailsState();
}

class MyCauseListDetailsState extends State<MyCauseListDetails>{

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cause List'),
      ),

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
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

              child: new Text('Cause List Date : '+ widget.causeDetails[0].causelistDate, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),

            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: /*ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:widget.causeDetails.length,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                itemBuilder: (context,index){
                  Details jd = widget.causeDetails[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.causeDetails[index].caseNo),
                  );
                }
            ),*/

    SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
        sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text("Hall NO"),
          ),
          DataColumn(
            label: Text("List No"),
          ),
          DataColumn(
            label: Text("Sl NO"),

          ),
          DataColumn(
            label: Text("Case NO"),
          ),
          DataColumn(
            label: Text("Bench"),
          ),
        ],
        rows: widget.causeDetails
            .map(
              (causeDetails) => DataRow(
            cells: [
              DataCell(
                Text('${causeDetails.benchId}'),
              ),
              DataCell(
                Text('${causeDetails.listNo}'),
              ),
              DataCell(
                Text('${causeDetails.srNo}'),
              ),
              DataCell(
                Text('${causeDetails.caseNo}'),
              ),
              DataCell(
                Text('${causeDetails.loc}'),
              ),
            ],
          ),
        )
            .toList()),
    ),),


          ),
        ],
      ),
    );
  }




}