import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/court_hall_model.dart';
import 'package:hck_case_management/Models/judge_model.dart';
import 'package:hck_case_management/Models/my_cause_list.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Screens/WebViewScreen/WebViewPage.dart';
import 'package:hck_case_management/Screens/mycauselist/my_cause_list_screen.dart';
import 'package:hck_case_management/Widgets/date_fields.dart';
import 'package:hck_case_management/Widgets/drop_down_field.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:hck_case_management/Widgets/round_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CauseListPage extends StatefulWidget {

  @override
  _CauseListPageState createState() => _CauseListPageState();
}
class _CauseListPageState extends State<CauseListPage> {
  List<String> searchType = ["Court Hall","Judge Name"];
  String selectedctype;

  List<BenchModel> benchList = [];
  BenchModel selectedBench;

  List<CourtHallModel> courtList = [];
  CourtHallModel selectedCourt;

  List<Judge_name> judgeList = [];
  Judge_name selectedJudge;

  String url;
  DateTime cdate;

  @override
  void initState() {
    selectedctype = searchType[0];
    cdate=DateTime.now();
    getBench();
    getCourtHall();
    //err=new ErrorMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cause List"),
        actions:<Widget>[
          Container(
            width: 130,
            child: FlatButton(
              onPressed: () async {await _causelistItem(); },
              color: Colors.red,
              padding: EdgeInsets.all(1.0),
              child: Row(
                // Replace with a Row for horizontal icon + textremove_red_eye_outlined
                children: <Widget>[Icon(Icons.remove_red_eye_outlined,size: 26.0,color: Colors.white,), Text("My Cause List",style: TextStyle(color: Colors.white,fontSize: 14),)],
              ),
            ),
          ),
        ],
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
                      DropDownFiled(label: "Select Bench",
                        from: "bench",
                        hintText: "Choose Bench",
                        dropdownValue: selectedBench,
                        dropDownArray: benchList,
                        onChanged: (val) {
                          setState(() {
                            selectedBench = val;
                            getCourtHall();
                          });
                        },
                      ),
                      DropDownFiled(label: "Search By",
                        from: "searchby",
                        hintText: "Choose Search By",
                        dropdownValue: selectedctype,
                        dropDownArray: searchType,
                        onChanged: (val) {
                          setState(() {
                            selectedctype = val;
                          });
                        },),

                      selectedctype=="Court Hall"?DropDownFiled(label: "Select Court Hall",
                        from: "court",
                        hintText: "Choose Court Hall",
                        dropdownValue: selectedCourt,
                        dropDownArray: courtList,
                        onChanged: (val) {
                          setState(() {
                            selectedCourt = val;
                          });
                        },
                      ):DropDownFiled(label: "Hon`ble Judges",from: "judge",hintText: "Select",
                        dropdownValue: selectedJudge, dropDownArray: judgeList,onChanged: (val){
                          setState(() {
                            selectedJudge = val;
                            print(selectedJudge.judgeCode);
                          });
                        },),
                      SizedBox(height: 20,),

                      DateFields(initialDate: DateTime.now(),firstDate: DateTime(1998),label: "Cause List Date",func: (DateTime value) {
                        setState(() {
                          cdate = value;
                          print(cdate);
                        });
                      },),

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

                  child: RoundButton(text: "View Cause List",
                    onPressed: () {

                    url=null;
                      String formattedDate;
                    cdate==null?setError("Select Cause List Date"):formattedDate= DateFormat('dd/MM/yyyy').format(cdate);

                      if(selectedBench==null){
                        setError("Select Bench");
                      }

                      else if(selectedctype==null){
                        setError("Select Search Type");
                      }

                      else if(selectedctype=="Court Hall"){
                        if(selectedCourt==null){
                          setError("Select Court Hall");
                        }
                        else{
                          url="https://karnatakajudiciary.kar.nic.in/appCauseListSearchResp.php?flg=2&so=1&bench="+selectedBench.id+"&SearchType=1&keyWord="+selectedCourt.id.toString()+"&fromDt="+formattedDate+"&toDt="+formattedDate;
                        }
                      }

                      else if(selectedctype=="Judge Name"){

                        if(selectedJudge==null || selectedJudge=="null" || selectedJudge==""){
                          setError("Select Hon`ble Judge Name");
                        }
                        else{
                          url="https://karnatakajudiciary.kar.nic.in/appCauseListSearchResp.php?flg=2&so=2&bench="+selectedBench.id+"&SearchType=2&keyWord="+selectedJudge.judgeName+"&fromDt="+formattedDate+"&toDt="+formattedDate;
                        }
                      }
                      url==null?setError("Select All Fields"):NavHistory.pushPage(context, WebViewPage(title: "Cause List",initUrl: url,));
                      //onGetStatus();
                    },
                    fontSize: 18,
                    color: Colors.red.shade400,
                    )
              )),
          Consumer<GlobalProvider>(builder: (context, global, child) {
            print(global.error);
            return LoadingScreen(isBusy: global.isBusy, error: global?.error,);
          }),
        ],
      ),

    );
  }

  getBench() async {
    List<BenchModel> bench = await ApiService.getBench(context);
    if (bench != null) {
      setState(() {
        benchList = bench;
        selectedBench = benchList[0];
      });
    }
  }

  getCourtHall() async {
    print("selectedBench");
    print(selectedBench);
    selectedJudge=null;
    String url;
    selectedBench == null ? url = "courthall.php?bench=B" : url =
        "courthall.php?bench=" + selectedBench.id;

    List<CourtHallModel> court = await ApiService.getCourtHall(context, url);
    if (court != null) {
      setState(() {
        courtList = court;
        selectedCourt = courtList[0];
      });

    }

    String benchurl;
    selectedBench == null ? benchurl = "causelistjudgename.php?bench=B" : benchurl =
        "causelistjudgename.php?bench=" + selectedBench.id;
    JudgeModel jud = await ApiService.getJudgeName(context,benchurl);
    if(jud != null){
      setState(() {
        judgeList = jud.judgeName;

      });

    }

  }

  setError(String val){
    Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, val);
  }

  var mnumber;
  Future<void> _causelistItem() async {
    //print(mnumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mno = (prefs.getString('Mobile_NUMBER') ?? 0);
    setState(() {
      mnumber = mno;
    });
    //var url = 'https://karnatakajudiciary.kar.nic.in/api/tempcauselist.php?mobile=' +
       // mnumber.toString();

    var url = 'tempcauselist.php?mobile=' + mnumber.toString();
    MyCauseList res = await ApiService.getCauseList(context, url);
    print("res");

    if (res != null) {
      if(res.status==1){
        NavHistory.pushPage((context),MyCauseListDetails(causeDetails:res.details,) );
      }
      else{
        setError("No Data Found");
      }
    }

  }

}