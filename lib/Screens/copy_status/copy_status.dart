import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Models/cca_three_caseno.dart';
import 'package:hck_case_management/Models/cca_three_crno.dart';
import 'package:hck_case_management/Models/cr_by_case_no.dart';
import 'package:hck_case_management/Models/crno_model.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Screens/copy_status/CcaCrCaseDetails.dart';
import 'package:hck_case_management/Screens/copy_status/CcaCrCaseDetailsList.dart';
import 'package:hck_case_management/Screens/copy_status/CrCaseDetails.dart';
import 'package:hck_case_management/Screens/copy_status/CrCaseDetailsList.dart';
import 'package:hck_case_management/Widgets/drop_down_field.dart';
import 'package:hck_case_management/Widgets/label_field.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:hck_case_management/Widgets/round_button.dart';
import 'package:provider/provider.dart';

class CopyingStatus extends StatefulWidget {
  @override
  _CopyingStatusState createState() => _CopyingStatusState();
}

class _CopyingStatusState extends State<CopyingStatus> {
  List<String> corf = ["Case Number", "CR Number"];
  String selectedctype;

  List<Copy_four_status> crCaseList;
  List<Cert_fresh> crList;

  List<Copy3_status> ccacrCaseList;
  List<Copy3> ccacrList;
  List<Cert_interim> interimList;

  List<String> searchList = ["CCA IV", "CCA III"];
  String searchType;

  TextEditingController mCaseNo = TextEditingController();

  List<Case_types> caseTypeList = [];
  Case_types selectedCaseType;

  List<BenchModel> benchList = [];
  BenchModel selectedBench;

  List<String> yearsList = [];
  String selectedYear;

  @override
  void initState() {
    yearsList = Utils.getYearList();
    selectedctype = corf[1];
    searchType = searchList[0];
    getCaseTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certified Copy Status"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      DropDownFiled(
                        label: "Select Bench",
                        from: "bench",
                        hintText: "Choose Bench",
                        dropdownValue: selectedBench,
                        dropDownArray: benchList,
                        onChanged: (val) {
                          setState(() {
                            selectedBench = val;
                          });
                        },
                      ),
                      DropDownFiled(
                        label: "Application Type",
                        from: "searchby",
                        hintText: "Choose Application Type",
                        dropdownValue: searchType,
                        dropDownArray: searchList,
                        onChanged: (val) {
                          setState(() {
                            searchType = val;
                            print(searchType);
                          });
                        },
                      ),
                      DropDownFiled(
                        label: "Search By",
                        from: "searchby",
                        hintText: "Choose Search By",
                        dropdownValue: selectedctype,
                        dropDownArray: corf,
                        onChanged: (val) {
                          setState(() {
                            selectedctype = val;
                            print(selectedctype);
                          });
                        },
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
                      LabelField(
                        label: selectedctype == "Case Number"
                            ? "Case Number"
                            : "CR Number",
                        mCtrl: mCaseNo,
                        maxLength: 6,
                        keytype: "Number",
                      ),
                      DropDownFiled(
                        label: selectedctype == "Case Number"
                            ? "Select Case Year"
                            : "Select Cr Year",
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
                text: "View Details",
                onPressed: () {
                  //NavHistory.pushPage(context, CaseDetails());
                  onGetStatus();
                },

                fontSize: 18,
                color: Colors.red.shade400,

              ))),
          Consumer<GlobalProvider>(builder: (context, global, child) {
            print(global.error);
            return LoadingScreen(
              isBusy: global.isBusy,
              error: global?.error,
            );
          }),
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
        selectedBench = benchList[0];
      });
    }
  }

  setError(String val) {
    Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, val);
  }

  //Future<void> onGetStatus() async
  Future<void> onGetStatus() async {
    String url1 = "";
    if (selectedBench == null) {
      setError("Select Bench");
    } else if (searchType == null || searchType == "null") {
      setError("Select Application Type");
    } else if (selectedctype == null || selectedctype == "null") {
      setError("Select Search By");
    } else if (selectedCaseType == null) {
      setError("Select Case Type");
    } else if (mCaseNo.text == null || mCaseNo.text == "") {
      setError("Enter Valid Case/CR No");
    } else if (selectedYear == null) {
      setError("Select year");
    } else {
      if (searchType == "CCA IV" && selectedctype == "Case Number") {
        url1 = "copying_caseno.php?bench=" +
            selectedBench.id +
            "&case_type=" +
            selectedCaseType.typeName +
            "&case_no=" +
            mCaseNo.text +
            "&case_year=" +
            selectedYear;
        CrByCaseNo res = await ApiService.getCrByCase(context, url1);
        if (res != null) {
          crCaseList = res.copyFourStatus;
          NavHistory.pushPage(
              context,
              CrCaseDetails(
                crCaseList: crCaseList,
                benchdet: selectedBench,
              ));
        }
       
      } else if (searchType == "CCA IV" && selectedctype == "CR Number") {
        url1 = "copying_crno.php?bench=" +
            selectedBench.id +
            "&case_type=" +
            selectedCaseType.typeName +
            "&cr_no=" +
            mCaseNo.text +
            "&cr_year=" +
            selectedYear;
        CrnoModel res = await ApiService.getCrNoDetails(context, url1);
        if (res != null) {
          crList = res.certFresh;
          NavHistory.pushPage(
              context,
              CrCaseDetailsList(
                crDetails: crList,
                benchdet: selectedBench,
              ));
        }
        //
      } else if (searchType == "CCA III" && selectedctype == "Case Number") {
        print("in cc caseno");
        url1 = "copying3_caseno.php?bench=" +
            selectedBench.id +
            "&case_type=" +
            selectedCaseType.typeName +
            "&case_no=" +
            mCaseNo.text +
            "&case_year=" +
            selectedYear;
        CcaThreeCaseno res =
            await ApiService.getCcaCrByCase(context, url1); //ccacrCaseList
        if (res != null) {
          ccacrCaseList = res.copy3Status;
          NavHistory.pushPage(
              context,
              CcaCrCaseDetails(
                ccacrCaseList: ccacrCaseList,
                benchdet: selectedBench,
              ));
        }
      } else if (searchType == "CCA III" && selectedctype == "CR Number") {
        print("in cc crno");
        url1 = "copying3_crno.php?bench=" +
            selectedBench.id +
            "&case_type=" +
            selectedCaseType.typeName +
            "&cr_no=" +
            mCaseNo.text +
            "&cr_year=" +
            selectedYear;
        CcaThreeCrno res = await ApiService.getCcaCrNoDetails(context, url1);
        print(res.status);
        if (res != null) {
          ccacrList = res.copy3;
          interimList = res.certInterim;
          NavHistory.pushPage(
              context,
              CcaCrCaseDetailsList(
                copyList: ccacrList,
                interimList: interimList,
                benchdet: selectedBench,
              ));
        }
      }
      print(url1);
    }

  }
}
