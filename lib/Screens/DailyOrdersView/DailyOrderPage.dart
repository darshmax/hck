

import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Models/daily_order_model.dart';
import 'package:hck_case_management/Models/judge_model.dart';
import 'package:hck_case_management/Models/judgement_model.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Screens/DailyOrdersView/OrderDetails.dart';
import 'package:hck_case_management/Screens/JudgmentScreen/JudgementDetails.dart';
import 'package:hck_case_management/Widgets/drop_down_field.dart';
import 'package:hck_case_management/Widgets/label_field.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:hck_case_management/Widgets/round_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

class DailyOrderPage extends StatefulWidget{
  @override
  _DailyOrderPageState createState() => _DailyOrderPageState();


}

class _DailyOrderPageState extends State<DailyOrderPage> {

  TextEditingController mCaseNo = TextEditingController();
  DateTime fdate;
  DateTime todate;
  DateTime lasttodate;

  List<Case_types> caseTypeList = [];
  Case_types selectedCaseType;

  List<Judge_name> judgeList = [];
  Judge_name selectedJudge;

  //DailyOrderModel
  List<Dailyorder_details> ordertList = [];

  List<BenchModel> benchList = [];
  BenchModel selectedBench;

  List<String> yearsList = [];
  String selectedYear;

  List<String> corf=["Judge Name","Case Number"];
  String selectedctype;

  Widget tofield;


  @override
  void initState() {
    yearsList = Utils.getYearList();
    getCaseTypes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Order"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      DropDownFiled(label: "Select Bench",from: "bench",hintText: "Choose Bench",
                        dropdownValue: selectedBench, dropDownArray: benchList,onChanged: (val){
                          setState(() {
                            selectedBench = val;
                            getJudge();
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      DropDownFiled(label: "Search By",from: "searchby",hintText: "Choose Search By",
                        dropdownValue: selectedctype, dropDownArray: corf,onChanged: (val){
                          setState(() {
                            if(selectedBench==null){
                              Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, "Select Bench");

                            }
                            else{
                              selectedctype = val;
                            }

                          });
                        },),

                      if(selectedctype=="Case Number")
                        Column(
                          children: [
                            SizedBox(height: 10,),
                            DropDownFiled(label: "Select Case Type",from: "case_type",hintText: "Choose Case Type",
                              dropdownValue: selectedCaseType, dropDownArray: caseTypeList,onChanged: (val){
                                setState(() {
                                  selectedCaseType = val;
                                });
                              },),
                            SizedBox(height: 10,),
                            LabelField(label: "Case Number",mCtrl: mCaseNo,maxLength: 6,keytype: "Number",),
                            SizedBox(height: 10,),
                            DropDownFiled(label: "Select Year",from: "year",hintText: "Choose year",
                              dropdownValue: selectedYear, dropDownArray: yearsList,onChanged: (val){
                                setState(() {
                                  selectedYear = val;
                                });
                              },),
                            SizedBox(height: 20,),

                          ],
                        ),
                      if(selectedctype=="Judge Name")
                        Column(
                          children: [
                            SizedBox(height: 10,),

                            DropDownFiled(label: "Hon`ble Judges",from: "judge",hintText: "Select",
                              dropdownValue: selectedJudge, dropDownArray: judgeList,onChanged: (val){
                                setState(() {
                                  selectedJudge = val;
                                  print(selectedJudge.judgeCode);
                                });
                              },),

                            SizedBox(height: 20,),

                            DateTimeFormField(
                              lastDate: DateTime.now(),
                              firstDate: DateTime(1998),
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))

                                ),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'From Date',
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.onUserInteraction,

                              onDateSelected: (DateTime value) {
                                setState(() {
                                  fdate = value;
                                  lasttodate=null;
                                  tofield=null;
                                  setToField();
                                });

                              },
                            ),

                            SizedBox(height: 20,),

                            tofield  != null ? tofield: SizedBox.shrink(),

                          ],
                        ),

                      if(selectedctype=="")
                        SizedBox.shrink()


                    ],
                  ),
                ),

              ),
            ],
          ),
          Positioned(
              bottom: 3,
              left: 20,
              right: 20,
              child: Container(

                child:  RoundButton(text: "View Daily Order",onPressed: selectedctype == null   ? null : onGetDailyOrder,fontSize: 18,color: Colors.red.shade400,),
              )),
          Consumer<GlobalProvider>(builder: (context, global, child){
            print(global.error);
            return LoadingScreen(isBusy: global.isBusy,error: global?.error,);
          })
        ],
      ),
    );
  }

  getCaseTypes()async{
    CaseTypeModel res = await ApiService.getCaseType(context);
    if(res != null){
      setState(() {
        caseTypeList = res.caseTypes;
      });

    }

    List<BenchModel> bench = await ApiService.getBench(context);
    if(res != null){
      setState(() {
        benchList = bench;
      });

    }
  }

  getJudge() async{
    selectedJudge=null;
    //judgeList=null;
    String url;
    selectedBench == null ? url = "judgename.php?bench=B" : url =
        "judgename.php?bench=" + selectedBench.id;
    JudgeModel jud = await ApiService.getJudgeName(context,url);
    if(jud != null){
      setState(() {
        judgeList = jud.judgeName;

      });

    }


  }

  Future<void> onGetDailyOrder() async {
    String url;
    //print(selectedctype+":"+selectedBench.id+":"+selectedJudge.judgeCode+":"+fdate.toString()+":"+todate.toString());
    if(selectedctype=="Judge Name"){
      String fromDate = DateFormat('yyyy-MM-dd').format(fdate);
      String toDate = DateFormat('yyyy-MM-dd').format(todate);
      url="dailyorderdetails.php?bench="+selectedBench.id+"&type=J&details="+selectedJudge.judgeName+"@"+fromDate+"@"+toDate;


    }

    else{
      url="dailyorderdetails.php?bench="+selectedBench.id+"&type=C&details="+selectedCaseType.typeName+"@"+mCaseNo.text+"@"+selectedYear;
    }

    DailyOrderModel res = await ApiService.getDailyOrdersDetails(context,url);
    print(res.status);
    if(res != null){
      ordertList = res.dailyorderDetails;
      NavHistory.pushPage(context, OrderDetails(orderDetails: ordertList,));
    }

  }

  setToField() {

    todate=null;
    lasttodate=fdate.add(new Duration(days: 30));
    print(lasttodate.isAfter(DateTime.now()));
    lasttodate.isAfter(DateTime.now())==true ? lasttodate=DateTime.now():lasttodate=lasttodate;
    print(fdate);
    print(lasttodate);
    todate=lasttodate;
    setState(() {
      tofield=DateTimeFormField(
        initialValue: lasttodate,
        firstDate: fdate,
        lastDate: lasttodate,
        decoration: const InputDecoration(

          hintStyle: TextStyle(color: Colors.black45),
          errorStyle: TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
          suffixIcon: Icon(Icons.event_note),
          labelText: 'To Date',
        ),
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.disabled,


        onDateSelected: (DateTime value) {
          todate = value;
          print("in todate");
          print(todate);
        },
      );
    });

  }



}


