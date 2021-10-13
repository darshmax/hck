import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/cca_three_crno.dart';

class CcaCrCaseDetailsList extends StatefulWidget {
  final List<Cert_interim> interimList;
  final List<Copy3> copyList;
  final BenchModel benchdet;

  const CcaCrCaseDetailsList(
      {Key key, this.benchdet, this.interimList, this.copyList})
      : super(key: key);

  @override
  FullCcaCrCaseDetailsList createState() => FullCcaCrCaseDetailsList();
}

class FullCcaCrCaseDetailsList extends State<CcaCrCaseDetailsList> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 12);

        return new Padding(
          padding: padding,
          child: new InkWell(
            child: new Container(
              //height: 200.0,
              width: 200.0,
              child: new Stack(
                children: <Widget>[
                  new Align(
                    alignment: Alignment.bottomCenter,
                    child: new Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade100,
                                blurRadius: 3,
                                offset: Offset(2, 4),
                                spreadRadius: 2)
                          ]),
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
                                  Text(
                                    "CR No:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.copyList[index].caseType +
                                        " " +
                                        widget.copyList[index].crNo +
                                        "/" +
                                        widget.copyList[index].crYear,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                              Text(
                                "Status : " + widget.copyList[index].dispType,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Case No : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 10,
                                child: Text(
                                  widget.copyList[index].caseType +
                                      " " +
                                      widget.copyList[index].caseno +
                                      "/" +
                                      widget.copyList[index].caseyear,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Applcant",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Text(widget.copyList[index].appliName))
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Date Filed",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Text(widget.copyList[index].dateFil))
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Copying Charges",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Text(widget.copyList[index].courtFee))
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Date of Delivery",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 10,
                                child:
                                    Text(widget.copyList[index].dateDelivery),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Date of Action",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 10,
                                child:
                                Text(widget.copyList[index].dateDisp),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: widget.copyList.length,
    );

    final body = new Scaffold(
      appBar: new AppBar(
        title: new Text("Certified Copy Status"),
      ),
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 15.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      height: 300.0, width: _width, child: headerList),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Sl No ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 10,
                            child: Text(
                              "Type of Request",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),

                        SizedBox(
                          width: 5,
                        ),

                        Expanded(
                            flex: 3,
                            child: Text(
                              "Copies",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),

                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 10,
                            child: Text(
                              "Remarks",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),

                      ],
                    ),
                  ),

                  new Divider(),

                  new Expanded(
                      child: ListView.builder(
                          itemCount:widget.interimList.length,
                          itemBuilder: (context, index) {
                            return new ListTile(
                              title: new Column(
                                children: <Widget>[

                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          flex: 10,
                                          child: Text(
                                            widget.interimList[index].typeOfRequest,
                                            style: TextStyle(
                                                fontSize: 14,),
                                          )),

                                      SizedBox(
                                        width: 5,
                                      ),

                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            //"Copies ssssssssssssssss ssssssssssssssss  ssssssssss",
                                            widget.interimList[index].noOfCopies,
                                            style: TextStyle(
                                                fontSize: 14,),
                                          )),

                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          flex: 10,
                                          child: Text(
                                            widget.interimList[index].remarks,
                                            //"Remarkssss sssssssssssss sssssssssssssssssssss ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                                            style: TextStyle(
                                                fontSize: 14),
                                          )),
                                    ],
                                  ),

                                  new Divider(),
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new Stack(
        children: <Widget>[

          body,
        ],
      ),
    );
  }
}
