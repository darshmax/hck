import 'package:flutter/material.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/crno_model.dart';



class CrCaseDetailsList extends StatefulWidget {
  final List<Cert_fresh> crDetails;
  final BenchModel benchdet;

  const CrCaseDetailsList({Key key, this.crDetails,this.benchdet}) : super(key: key);

  @override
  FullCrCaseDetailsList createState() => FullCrCaseDetailsList();
}

class FullCrCaseDetailsList extends State<CrCaseDetailsList>{

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Certified Copy Status'),
      ),

      body:  ListView(

          children: <Widget>[
            SizedBox(height: 15,),

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

                child: new Text('Status : '+widget.crDetails[0].dispYn, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),

              ),
            ),
            SizedBox(height: 15,),
            DataTable(
              columnSpacing: 10,
              //dataRowHeight: 50,
              //headingRowHeight: 50,

              dividerThickness: 5,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300],width: 5)
              ),
              columns: [

                DataColumn(

                    label: Text(
                        'CR No',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    )),
                DataColumn(label: Text(widget.crDetails[0].caseType+" "+widget.crDetails[0].crNo+"/"+widget.crDetails[0].crYear,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),

              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Case No',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].caseType+" "+widget.crDetails[0].caseno+"/"+widget.crDetails[0].caseyear,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Applcant',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].appliName,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Date Filed',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].dateFil,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Date of Order ',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].dateOrder,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Date of Action ',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].readyDate,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Copying Charges  ',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].courtFee,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Delivery Mode',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].deliveryMode,style: TextStyle(fontSize: 18,),)),
                ]),

                DataRow(cells: [
                  DataCell(Text('Date of Delivery',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),)),
                  DataCell(Text(widget.crDetails[0].dateDelivery,style: TextStyle(fontSize: 18,),)),
                ]),

                // DataRow(cells: [
                //   DataCell(Text('Due/Refund ',style: TextStyle(
                //       fontSize: 18, fontWeight: FontWeight.bold
                //   ),)),
                //   int.parse(widget.crDetails[0].paymentDue)==0 ? DataCell(Text(widget.crDetails[0].paymentDue,style: TextStyle(fontSize: 18,),)):
                //   int.parse(widget.crDetails[0].paymentDue)> 0 ? DataCell(Text(widget.crDetails[0].paymentDue + "(Due)",style: TextStyle(fontSize: 18,),)):
                //    DataCell(Text(widget.crDetails[0].paymentDue + "(Refund)",style: TextStyle(fontSize: 18,),)),
                // ]),

              ],
            ),
          ]),


    );
  }


}