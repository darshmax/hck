import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/cr_by_case_no.dart';
import 'package:hck_case_management/Models/crno_model.dart';
import 'package:hck_case_management/Screens/copy_status/CrCaseDetailsList.dart';
import 'package:hck_case_management/Screens/copy_status/CrCaseList.dart';

class CrCaseDetails extends StatefulWidget {
  final List<Copy_four_status> crCaseList;
  final BenchModel benchdet;
  const CrCaseDetails({Key key, this.crCaseList,this.benchdet}) : super(key: key);
  

  @override
  FullCrCaseCrDetails createState() => FullCrCaseCrDetails();
}
class FullCrCaseCrDetails extends State<CrCaseDetails>{

  final TextEditingController searchChar = TextEditingController();
  String searchQuery="";
  List<Copy_four_status> _filteredList = [];


  @override
  void dispose() {
    searchChar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _filteredList = widget.crCaseList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Certified Copy Status'),
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
                        Text("Total Applications : ", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.redAccent,fontSize: 16),)
                      ],
                    ),
                    Text(_filteredList.length.toString(), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green,fontSize: 16),)

                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:_filteredList.length,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                itemBuilder: (context,index){
                  Copy_four_status cd = _filteredList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CrCaseList(cs: cd,onDownload: () async {
                      String urlcr = "copying_crno.php?bench=" +
                          widget.benchdet.id + "&case_type=" + cd.caseType +
                          "&cr_no=" + cd.crNo + "&cr_year=" + cd.crYear;
                      List<Cert_fresh> crList;
                      CrnoModel res = await ApiService.getCrNoDetails(
                          context, urlcr);
                      print(res.status);
                      if (res != null) {
                        crList = res.certFresh;
                        NavHistory.pushPage(context, CrCaseDetailsList(crDetails: crList,benchdet:widget.benchdet,));
                      }
                    }),

                        );
                }
            ),
          ),


        ],
      ),

    );
  }

  bool getSearch(Copy_four_status e, String val){
    val = val.toLowerCase();
    return e.caseType.toLowerCase().contains(val) || e.appliName.toLowerCase().contains(val) || e.crYear.toLowerCase().contains(val) || e.crNo.toLowerCase().contains(val);
  }

  updateSearchRes(String val) {
    print(val);
    if(val.length > 0){
      _filteredList = widget.crCaseList.where((e) => getSearch(e, val)).toList();
    }else{
      _filteredList = widget.crCaseList;
    }

    setState(() {
      searchQuery = val;
    });
  }
}
