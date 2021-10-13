import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Screens/WebViewScreen/WebViewPage.dart';
import 'package:hck_case_management/Widgets/drop_down_field.dart';
import 'package:hck_case_management/Widgets/label_field.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:hck_case_management/Widgets/round_button.dart';
import 'package:provider/provider.dart';



class CheckSlipScreen extends StatefulWidget {

  @override
  _CheckSlipScreenState createState() => _CheckSlipScreenState();
}

class _CheckSlipScreenState extends State<CheckSlipScreen> {
  TextEditingController mCaseNo = TextEditingController();

  List<Case_types> caseTypeList = [];
  Case_types selectedCaseType;

  List<BenchModel> benchList = [];
  BenchModel selectedBench;

  List<String> yearsList = [];
  String selectedYear;

  List<String> corf=["Case Number","FR Number"];
  String selectedctype;


  @override
  void initState() {
    selectedctype=corf[1];
    yearsList = Utils.getYearList();
    getCaseTypes();
    super.initState();
  }

  getCaseTypes()async{
      CaseTypeModel res = await ApiService.getCaseType(context);
      if(res != null){
        setState(() {
          caseTypeList = res.caseTypes;
          //selectedCaseType=caseTypeList[0];
        });

      }

      List<BenchModel> bench = await ApiService.getBench(context);
      if(res != null){
        setState(() {
          benchList = bench;
          selectedBench = benchList[0];
        });

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Office Objection"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
                  SingleChildScrollView(
                    child:  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [

                          DropDownFiled(label: "Select Bench",from: "bench",hintText: "Choose Bench",
                            dropdownValue: selectedBench, dropDownArray: benchList,onChanged: (val){
                              setState(() {
                                selectedBench = val;
                              });
                            },
                          ),

                          DropDownFiled(label: "Search By",from: "searchby",hintText: "Choose Search By",
                            dropdownValue: selectedctype, dropDownArray: corf,onChanged: (val){
                              setState(() {
                                selectedctype = val;
                              });
                            },),

                          SizedBox(width: 8,),



                          DropDownFiled(label: "Select Case Type",from: "case_type",hintText: "Choose Case Type",
                            dropdownValue: selectedCaseType, dropDownArray: caseTypeList,onChanged: (val){
                              setState(() {
                                selectedCaseType = val;
                              });
                            },),
                          LabelField(label: "Case Number",mCtrl: mCaseNo,maxLength: 6,keytype: "Number",),
                          DropDownFiled(label: "Select Year",from: "year",hintText: "Choose year",
                            dropdownValue: selectedYear, dropDownArray: yearsList,onChanged: (val){
                              setState(() {
                                selectedYear = val;
                              });
                            },),
                          SizedBox(height: 20,),

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

                child:  RoundButton(text: "View Office Objection",onPressed: (){
                  //NavHistory.pushPage(context, CaseDetails());
                  onGetCheckSlip();
                },fontSize: 18,color: Colors.red.shade400,)
              )),
          Consumer<GlobalProvider>(builder: (context, global, child){
            print(global.error);
            return LoadingScreen(isBusy: global.isBusy,error: global?.error,);
          }),
        ],
      ),

    );
  }

  setError(String val){
    Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, val);
  }

  onGetCheckSlip()  {
    String url;
    String type;

    if(selectedBench == null){
      setError("Select Bench");

    }
    else if(selectedctype==null || selectedctype=="null"){
      setError("Select Search By");
    }
    else if(selectedCaseType==null){
      setError("Select Case Type");
    }
    else if(mCaseNo.text==null || mCaseNo.text==""){
      setError("Enter Valid Case No");
    }
    else if(selectedYear==null){
      setError("Select year");
    }
    else{
      if (selectedctype == "FR Number") {
        type = "F";
      }
      else {
        type = "C";
      }
       // url="https://karnatakajudiciary.kar.nic.in/telCauseListSearchResp.php?flg=2&so=1&bench=B&SearchType=1&keyWord=4&fromDt=22/09/2021&toDt=22/09/2021";
        url="https://karnatakajudiciary.kar.nic.in/appcheckslip.php?bench="+ selectedBench.id+"&type="+type+"&case_type="+selectedCaseType.typeName+"&case_no="+mCaseNo.text+"&case_year="+selectedYear.toString();
        NavHistory.pushPage(context, WebViewPage(title: "Office Objection",initUrl: url,));
    }


  }
}


