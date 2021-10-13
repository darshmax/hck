import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Models/judge_model.dart';
import 'package:hck_case_management/Models/judgement_model.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Screens/JudgmentScreen/JudgementDetails.dart';
import 'package:hck_case_management/Widgets/date_fields.dart';
import 'package:hck_case_management/Widgets/drop_down_field.dart';
import 'package:hck_case_management/Widgets/label_field.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:hck_case_management/Widgets/round_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

class JudgmetScreen extends StatefulWidget {
  @override
  _JudgmetScreenState createState() => _JudgmetScreenState();
}

class _JudgmetScreenState extends State<JudgmetScreen> {
  TextEditingController mCaseNo = TextEditingController();
  DateTime fdate;
  DateTime todate;
  DateTime lasttodate;

  List<Case_types> caseTypeList = [];
  Case_types selectedCaseType;

  List<Judge_name> judgeList = [];
  Judge_name selectedJudge;

  List<Judgment_details> judgementList = [];

  List<BenchModel> benchList = [];
  BenchModel selectedBench;

  List<String> yearsList = [];
  String selectedYear;

  List<String> corf = ["Judge Name", "Case Number"];
  String selectedctype;

  List<String> repyn = ["All", "Reportable", "Non Reportable"];
  String selectedrepyn;

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
        title: Text("Judgment"),
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
                      SizedBox(
                        height: 10,
                      ),
                      DropDownFiled(
                        label: "Select Bench",
                        from: "bench",
                        hintText: "Choose Bench",
                        dropdownValue: selectedBench,
                        dropDownArray: benchList,
                        onChanged: (val) {
                          setState(() {
                            selectedBench = val;
                            getJudge();
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropDownFiled(
                        label: "Search By",
                        from: "searchby",
                        hintText: "Choose Search By",
                        dropdownValue: selectedctype,
                        dropDownArray: corf,
                        onChanged: (val) {
                          setState(() {
                            if (selectedBench == null) {
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .setIsBusy(false, "Select Bench");
                            } else {
                              selectedctype = val;
                            }
                          });
                        },
                      ),
                      if (selectedctype == "Case Number")
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            DropDownFiled(
                              label: "Select Case Type",
                              from: "case_type",
                              hintText: "Choose Case Type",
                              dropdownValue: selectedCaseType,
                              dropDownArray: caseTypeList,
                              onChanged: (val) {
                                setState(() {
                                  selectedCaseType = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LabelField(
                              label: "Case Number",
                              mCtrl: mCaseNo,
                              maxLength: 6,
                              keytype: "Number",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropDownFiled(
                              label: "Select Year",
                              from: "year",
                              hintText: "Choose year",
                              dropdownValue: selectedYear,
                              dropDownArray: yearsList,
                              onChanged: (val) {
                                setState(() {
                                  selectedYear = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      if (selectedctype == "Judge Name")
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            DropDownFiled(
                              label: "Hon`ble Judges",
                              from: "judge",
                              hintText: "Select",
                              dropdownValue: selectedJudge,
                              dropDownArray: judgeList,
                              onChanged: (val) {
                                setState(() {
                                  selectedJudge = val;
                                  print(selectedJudge.judgeCode);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropDownFiled(
                              label: "Repotable",
                              from: "searchby",
                              hintText: "Select",
                              dropdownValue: selectedrepyn,
                              dropDownArray: repyn,
                              onChanged: (val) {
                                setState(() {
                                  selectedrepyn = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DateFields(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1998),
                              label: "From Date",
                              func: (DateTime value) {
                                setState(() {
                                  fdate = value;
                                  lasttodate = null;
                                  tofield = null;
                                  setToField();
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            tofield != null ? tofield : SizedBox.shrink(),
                          ],
                        ),
                      if (selectedctype == "") SizedBox.shrink()
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
                child: RoundButton(
                  text: "View Judgments",
                  onPressed: selectedctype == null ? null : onGetJudgment,
                  fontSize: 18,
                  color: Colors.red.shade400,
                ),
              )),
          Consumer<GlobalProvider>(builder: (context, global, child) {
            print(global.error);
            return LoadingScreen(
              isBusy: global.isBusy,
              error: global?.error,
            );
          })
        ],
      ),
    );
  }

  getCaseTypes() async {
    CaseTypeModel res = await ApiService.getCaseType(context);
    if (res != null) {
      setState(() {
        caseTypeList = res.caseTypes;
      });
    }

    List<BenchModel> bench = await ApiService.getBench(context);
    if (res != null) {
      setState(() {
        benchList = bench;
      });
    }
  }

  getJudge() async {
    selectedJudge = null;
    //judgeList=null;url = "judgename.php?bench=" + selectedBenches.id;
    String url;
    selectedBench == null
        ? url = "judgename.php?bench=B"
        : url = "judgename.php?bench=" + selectedBench.id;
    JudgeModel jud = await ApiService.getJudgeName(context, url);
    if (jud != null) {
      setState(() {
        judgeList = jud.judgeName;
      });
    }
  }

  Future<void> onGetJudgment() async {
    String url;
    String sType;

    //print(selectedctype+":"+selectedBench.id+":"+selectedJudge.judgeCode+":"+selectedrepyn+":"+fdate.toString()+":"+todate.toString());
    if (selectedctype == "Judge Name") {
      if (selectedrepyn == null || selectedrepyn == "") {
        print("null reported");
      } else if (selectedrepyn == "All") {
        sType = "A";
      } else if (selectedrepyn == "Reportable") {
        sType = "Y";
      } else {
        sType = "N";
      }
      String fromDate = DateFormat('yyyy-MM-dd').format(fdate);
      String toDate = DateFormat('yyyy-MM-dd').format(todate);
      url = "judgmentdetails.php?bench=" +
          selectedBench.id +
          "&type=J&details=" +
          selectedJudge.judgeCode +
          "@" +
          fromDate +
          "@" +
          toDate +
          "@" +
          sType;
    } else {
      url = "judgmentdetails.php?bench=" +
          selectedBench.id +
          "&type=C&details=" +
          selectedCaseType.typeName +
          "@" +
          mCaseNo.text +
          "@" +
          selectedYear;
    }

    JudgementModel res = await ApiService.getJudgementDetails(context, url);
    //print("res.status");
    //print(res.status);
    if (res != null) {
      judgementList = res.judgmentDetails;
      NavHistory.pushPage(
          context,
          JudgementDetails(
            judgementDetails: judgementList,
          ));
    }
  }

  setToField() {
    todate = null;
    lasttodate = fdate.add(new Duration(days: 30));
    print(lasttodate.isAfter(DateTime.now()));
    lasttodate.isAfter(DateTime.now()) == true
        ? lasttodate = DateTime.now()
        : lasttodate = lasttodate;
    print(fdate);
    print(lasttodate);
    todate = lasttodate;
    setState(() {
      // tofield=DateTimeFormField(
      //   initialValue: lasttodate,
      //   firstDate: fdate,
      //   lastDate: lasttodate,
      //   decoration: const InputDecoration(
      //
      //     hintStyle: TextStyle(color: Colors.black45),
      //     errorStyle: TextStyle(color: Colors.redAccent),
      //     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
      //     suffixIcon: Icon(Icons.event_note),
      //     labelText: 'To Date',
      //   ),
      //   mode: DateTimeFieldPickerMode.date,
      //   autovalidateMode: AutovalidateMode.disabled,
      //
      //
      //   onDateSelected: (DateTime value) {
      //     todate = value;
      //     print("in todate");
      //     print(todate);
      //   },
      // );
      tofield = DateFields(
        initialDate: todate,
        firstDate: fdate,
        lastDate: lasttodate,
        label: "To Date",
        func: (DateTime value) {
          setState(() {
            todate = value;
          });
        },
      );
    });
  }
}
