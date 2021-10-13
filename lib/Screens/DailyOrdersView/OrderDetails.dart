
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/daily_order_model.dart';
import 'package:hck_case_management/Models/judgement_model.dart';
import 'package:hck_case_management/Screens/DailyOrdersView/OrderList.dart';

//import 'Widgets/judgment_list.dart';

class OrderDetails extends StatefulWidget {
  final List<Dailyorder_details> orderDetails;

  const OrderDetails({Key key, this.orderDetails}) : super(key: key);

  @override
  FullOrderDetails createState() => FullOrderDetails();
}

class FullOrderDetails extends State<OrderDetails>{

  final TextEditingController searchChar = TextEditingController();
  String searchQuery="";
  List<Dailyorder_details> _filteredList = [];


  @override
  void dispose() {
    searchChar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _filteredList = widget.orderDetails;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Daily Order'),
      ),

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade200,
            ),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              autofocus: true,
              controller: searchChar,
              onChanged: (searchval) => updateSearchRes(searchval),
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search_off_outlined),
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  border: InputBorder.none

              ),
            ),
          ),

          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Cases :", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.redAccent,fontSize: 16),)
                      ],
                    ),
                    Text(_filteredList.length.toString(), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green,fontSize: 16),)

                  ],
                ),
              ),
            ],
          ),

          // Column(
          //   children: [
          //     Align(
          //       alignment: Alignment.centerRight,
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: Text("Total Cases:"+_filteredList.length.toString(),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900,fontSize: 16),textAlign: TextAlign.left,),
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:_filteredList.length,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                itemBuilder: (context,index){
                  Dailyorder_details od = _filteredList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderList(od: od),
                  );
                }
            ),
          ),


        ],
      ),






    );
  }

  bool getSearch(Dailyorder_details e, String val){
    val = val.toLowerCase();
    return e.caseType.toLowerCase().contains(val) || e.caseNo.toLowerCase().contains(val) || e.caseYear.toLowerCase().contains(val) || e.dailyOrder.toLowerCase().contains(val) || e.judgeName.toLowerCase().contains(val) || e.dateOfOrder.toLowerCase().contains(val);
  }

  updateSearchRes(String val) {
    print(val);
    if(val.length > 0){
      _filteredList = widget.orderDetails.where((e) => getSearch(e, val)).toList();
    }else{
      _filteredList = widget.orderDetails;
    }

    setState(() {
      searchQuery = val;
    });
  }


}