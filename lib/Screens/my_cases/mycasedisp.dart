import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hck_case_management/Models/mycases_model.dart';


class MycasesList extends StatelessWidget {
  final UserDetails od;

  const MycasesList({Key key, this.od}) : super(key: key);
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
        children: [
          // Column(
          //   children: [
          //     Center(
          //       child: Text("Case No : "+od.caseType+" "+od.caseNo+"/"+od.caseYear,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),),
          //     )
          //   ],
          // ),
          Column(
            //child: Text("Case No : "+od.caseType+" "+od.caseNo+"/"+od.caseYear,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text("Case No : ", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),)),
                  SizedBox(width: 10,),
                  Expanded(flex: 10,child: Text(od.casetype+" "+od.caseno+"/"+od.caseyear,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),))
                ],
              ),

              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text("Date : ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                  SizedBox(width: 10,),
                  Expanded(flex: 10,child: Text(od.caseyear))
                ],
              ),
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text("Hon`ble Judge(s) : ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                  SizedBox(width: 10,),
                  Expanded(flex: 10,child: Text(od.caseyear))
                ],
              ),
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text("Order : ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                  SizedBox(width: 10,),
                  Expanded(flex: 10,child: Text(od.caseyear))
                ],
              ),


            ],
          ),
        ],
      ),

    );
  }
}
