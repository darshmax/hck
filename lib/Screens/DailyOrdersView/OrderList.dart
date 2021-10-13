import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hck_case_management/Models/daily_order_model.dart';


class OrderList extends StatelessWidget {
  final Dailyorder_details od;

  const OrderList({Key key, this.od}) : super(key: key);
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
                      Expanded(flex: 10,child: Text(od.caseType+" "+od.caseNo+"/"+od.caseYear,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),))
                    ],
                  ),

                SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: Text("Date : ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                    SizedBox(width: 10,),
                    Expanded(flex: 10,child: Text(od.dateOfOrder))
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: Text("Hon`ble Judge(s) : ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                    SizedBox(width: 10,),
                    Expanded(flex: 10,child: Text(od.judgeName))
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: Text("Order : ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                    SizedBox(width: 10,),
                    Expanded(flex: 10,child: Text(od.dailyOrder))
                  ],
                ),


              ],
           ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text("Case No:", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
      //             SizedBox(height: 2,),
      //             Text(od.caseType+" "+od.caseNo+"/"+od.caseYear, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),)
      //           ],
      //         ),
      //         // TextButton.icon(onPressed: onDownload, icon: Icon(Icons.picture_as_pdf_outlined,color: Colors.green,), label: Text("Download",style: TextStyle(color: Colors.blue),),
      //         //   // TextButton(onPressed: onDownload, child: Text("Download",style: TextStyle(color: Colors.blue),),
      //         //
      //         //   style: TextButton.styleFrom(
      //         //
      //         //     padding: const EdgeInsets.symmetric(horizontal: 12),
      //         //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //         //   ),)
      //
      //       ],
      //     ),
      //     SizedBox(height: 8,),
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Expanded(flex: 4, child: Text("Date : ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
      //         SizedBox(width: 10,),
      //         Expanded(flex: 10,child: Text(od.dateOfOrder))
      //       ],
      //     ),
      //     SizedBox(height: 8,),
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Expanded(flex: 4, child: Text("Hon`ble Judge(s) : ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
      //         SizedBox(width: 10,),
      //         Expanded(flex: 10,child: Text(od.judgeName))
      //       ],
      //     ),
      //     SizedBox(height: 8,),
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Expanded(flex: 4, child: Text("Order : ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
      //         SizedBox(width: 10,),
      //         Expanded(flex: 10,child: Text(od.dailyOrder))
      //       ],
      //     ),
      //
      //
      //
      //
      //
      //   ],
      // ),
    );
  }
}
