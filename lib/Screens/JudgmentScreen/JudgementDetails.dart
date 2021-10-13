import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/navigator.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/judgement_model.dart';
import 'package:hck_case_management/Models/judgment_download_model.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Screens/WebViewScreen/PdfViewPage.dart';
import 'package:hck_case_management/Widgets/label_field.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'Widgets/judgment_list.dart';
import 'package:open_file/open_file.dart';

class JudgementDetails extends StatefulWidget {
  final List<Judgment_details> judgementDetails;

  const JudgementDetails({Key key, this.judgementDetails}) : super(key: key);

  @override
  FullJudgementDetails createState() => FullJudgementDetails();
}

class FullJudgementDetails extends State<JudgementDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchChar = TextEditingController();
  String searchQuery = "";
  List<Judgment_details> _filteredList = [];
  String savePath;

  JudgmentDownloadModel pdfData;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    searchChar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _filteredList = widget.judgementDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Judgement'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200,
                ),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: TextField(
                  autofocus: false,
                  controller: searchChar,
                  onChanged: (searchval) => updateSearchRes(searchval),
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search_off_outlined),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      border: InputBorder.none),
                ),

              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Cases :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.redAccent,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Text(
                          _filteredList.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.green,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _filteredList.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    itemBuilder: (context, index) {
                      Judgment_details jd = _filteredList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: JudgementList(
                          jd: jd,
                          onDownload: () {
                            downLoadJud(jd.typeName, jd.regNo, jd.regYear,
                                jd.dateOfDecision);
                            //Utils.launchUrl("http://karnatakajudiciary.kar.nic.in:8080/app_judgment1.php?data="+jd.typeName+"@"+jd.regNo+"@"+jd.regYear+"@"+jd.dateOfDecision);
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
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

  bool getSearch(Judgment_details e, String val) {
    val = val.toLowerCase();
    return e.title.toLowerCase().contains(val) ||
        e.petName.toLowerCase().contains(val) ||
        e.resName.toLowerCase().contains(val);
  }

  updateSearchRes(String val) {
    print(val);
    if (val.length > 0) {
      _filteredList =
          widget.judgementDetails.where((e) => getSearch(e, val)).toList();
    } else {
      _filteredList = widget.judgementDetails;
    }

    setState(() {
      searchQuery = val;
    });
  }

  Future<void> downLoadJud(String typeName, String regNo, String regYear,
      String dateOfDecision) async {
    if (await Permission.storage.request().isGranted) {
      String url = "judgmentdownload.php?data=" +
          typeName +
          "@" +
          regNo +
          "@" +
          regYear +
          "@" +
          dateOfDecision;
      print(url);
      JudgmentDownloadModel res =
          await ApiService.getDownloadData(context, url);
      print(res.status);
      if (res != null) {
        if (res.status == 1) {
          pdfData = res;
          final encodedStr = pdfData.judgmentDownload;
          Uint8List bytes = base64.decode(encodedStr);
          final fileName = pdfData.judgmentName;
          savePath = await ExternalPath.getExternalStoragePublicDirectory(
                  ExternalPath.DIRECTORY_DOWNLOADS) +
              "/" +
              fileName;
          print("File(savePath).exists()");
          bool fileExists = await File(savePath).exists();
          File file = File(savePath);
          if (fileExists) {
            await file.delete();
          }

          await file.writeAsBytes(bytes);
          OpenFile.open(savePath);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => PdfViewPage(
          //             appbarTitle: "Judgment",
          //             pathName: savePath,
          //           )),
          // );
        } else {
          Provider.of<GlobalProvider>(context, listen: false)
              .setIsBusy(false, "No Data Found");
        }
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, "No Data Found");
      }
    } else {
      print("please grant");
    }
  }
}
