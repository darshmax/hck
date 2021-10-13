import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Models/judgement_model.dart';


class JudgementList extends StatelessWidget {
  final Judgment_details jd;
  final Function onDownload;

  const JudgementList({Key key, this.jd, this.onDownload}) : super(key: key);
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
                  Text("Case No:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text(jd.title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent,fontSize: 14),)
                ],
              ),
              TextButton.icon(onPressed: onDownload, icon: Icon(Icons.picture_as_pdf_outlined,color: Colors.green,), label: Text("View Judgment",style: TextStyle(color: Colors.blue),),
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
              Expanded(flex: 4, child: Text("Pet. Name", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
              SizedBox(width: 10,),
              Expanded(flex: 10,child: Text(jd.petName))
            ],
          ),
          SizedBox(height: 8,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text("Res. Name", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
              SizedBox(width: 10,),
              Expanded(flex: 10,child: Text(jd.resName))
            ],
          ),
          SizedBox(height: 8,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text("Bench", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
              SizedBox(width: 10,),
              Expanded(flex: 10,child: Text(jd.benchDesc))
            ],
          ),
          SizedBox(height: 8,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text("Date of Decision", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
              SizedBox(width: 10,),
              Expanded(flex: 10,child: Text(jd.dateOfDecision))
            ],
          ),



        ],
      ),
    );
  }
}
