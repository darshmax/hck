import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Models/cr_by_case_no.dart';


class CrCaseList extends StatelessWidget {
  final Copy_four_status cs;
  final Function onDownload;

  const CrCaseList({Key key, this.cs, this.onDownload}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 3,
                offset: Offset(2,4),
                spreadRadius: 2
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CR No:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text(cs.caseType+" "+cs.crNo+"/"+cs.crYear, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent,fontSize: 14),)
                ],
              ),
              TextButton.icon(onPressed: onDownload, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.green,), label: Text("View Status",style: TextStyle(color: Colors.blue),),
                // TextButton(onPressed: onDownload, child: Text("Download",style: TextStyle(color: Colors.blue),),

                style: TextButton.styleFrom(

                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),)

            ],
          ),
          SizedBox(height: 8,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text("Applicant", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
              SizedBox(width: 10,),
              Expanded(flex: 10,child: Text(cs.appliName))
            ],
          ),
          SizedBox(height: 8,),

          SizedBox(height: 8,),

        ],
      ),
    );
  }
}
