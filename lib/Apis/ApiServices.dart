import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hck_case_management/Apis/api_base.dart';
import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/api_response.dart';
import 'package:hck_case_management/Apis/http_response.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_info.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Models/cca_three_caseno.dart';
import 'package:hck_case_management/Models/cca_three_crno.dart';
import 'package:hck_case_management/Models/court_hall_model.dart';
import 'package:hck_case_management/Models/cr_by_case_no.dart';
import 'package:hck_case_management/Models/crno_model.dart';
import 'package:hck_case_management/Models/daily_order_model.dart';
import 'package:hck_case_management/Models/judge_model.dart';
import 'package:hck_case_management/Models/judgement_model.dart';
import 'package:hck_case_management/Models/judgment_download_model.dart';
import 'package:hck_case_management/Models/my_cause_list.dart';
import 'package:hck_case_management/Models/sync_resp.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiService {
  static Future<CaseTypeModel> getCaseType(BuildContext context) async {
    var url = "casetype.php";
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    if (response.Status == 1) {
      CaseTypeModel caseTypeModel =
          CaseTypeModel.fromJson(json.decode(response.Data));
      if (caseTypeModel.status == 1) {
        return caseTypeModel;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, caseTypeModel.msg);
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
    return null;
  }

  static Future<List<BenchModel>> getBench(BuildContext context) async {
    var url = "benchname.php";
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      List<BenchModel> benchList =
          List<BenchModel>.from(val.map((model) => BenchModel.fromJson(model)));
      return benchList;
    }
    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
  }

  static Future<CaseInfo> getCaseDetails(BuildContext context, String ctype,
      String bench, String casetype, String caseno, String caseyear) async {
    print(ctype);
    String type;
    if (ctype == "FR Number") {
      type = "F";
    } else {
      type = "C";
    }

    var url = "casedetails_new.php?bench=" +
        bench +
        "&type=" +
        type +
        "&case_type=" +
        casetype +
        "&case_no=" +
        caseno +
        "&case_year=" +
        caseyear;
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      // print(val);
      CaseInfo caseList = CaseInfo.fromJson(val);
      print(caseList.status);
      if (caseList.status == 1) {
        return caseList;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, caseList.msg);
      }
    }
    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
    return null;
  }

  static Future<JudgeModel> getJudgeName(
      BuildContext context, String url) async {
    // var url = "judgename.php?bench=" + selectedBenches.id;
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);

    if (response.Status == 1) {
      JudgeModel judModel = JudgeModel.fromJson(json.decode(response.Data));
      if (judModel.status == 1) {
        return judModel;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, judModel.msg);
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }

    return null;
  }

  static Future<JudgementModel> getJudgementDetails(
      BuildContext context, String url) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      // print(val);
      JudgementModel jusgementList = JudgementModel.fromJson(val);
      print(jusgementList.status);
      if (jusgementList.status == 1) {
        return jusgementList;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, jusgementList.msg);
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
  }

  static Future<List<CourtHallModel>> getCourtHall(
      BuildContext context, String url) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      List<CourtHallModel> courtList = List<CourtHallModel>.from(
          val.map((model) => CourtHallModel.fromJson(model)));
      return courtList;
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
    return null;
  }

  static Future<DailyOrderModel> getDailyOrdersDetails(
      BuildContext context, String url) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    print(response.Data);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      // print(val);
      DailyOrderModel orderList = DailyOrderModel.fromJson(val);
      print(orderList.status);
      if (orderList.status == 1) {
        return orderList;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, orderList.msg);
      }
    }
    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }

  }

  static Future<CrByCaseNo> getCrByCase(
      BuildContext context, String url1) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url1, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      CrByCaseNo crList = CrByCaseNo.fromJson(val);
      if (crList.status == 1) {
        return crList;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, "No Data Found");
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
  }

  static Future<CrnoModel> getCrNoDetails(
      BuildContext context, String urlcr) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, urlcr, null);
    print(response.Status);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      CrnoModel crList = CrnoModel.fromJson(val);
      if (crList.status == 1) {
        return crList;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, "No Data Found");
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }

  }

  static Future<CcaThreeCaseno> getCcaCrByCase(
      BuildContext context, String url1) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url1, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      CcaThreeCaseno crccaList = CcaThreeCaseno.fromJson(val);
      if (crccaList.status == 1) {
        return crccaList;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, "No Data Found");
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
  }

  static Future<CcaThreeCrno> getCcaCrNoDetails(
      BuildContext context, String urlcr) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, urlcr, null);
    print(response.Status);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      CcaThreeCrno crLists = CcaThreeCrno.fromJson(val);
      if (crLists.status == 1) {
        return crLists;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, "No Data Found");
      }
    }

    else{
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Some thing went wrong");
    }
  }

  static Future<MyCauseList> getCauseList(
      BuildContext context, String url) async {
    //print(url);
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);
    if (response.Status == 1) {
      final val = json.decode(response.Data);
      MyCauseList causeLists = MyCauseList.fromJson(val);
      if (causeLists.status == 1) {
        return causeLists;
      } else {
        Provider.of<GlobalProvider>(context, listen: false)
            .setIsBusy(false, "No Data Found");
      }
    } else {
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "No Data Found");
    }
  }

  static Future<SyncResp> getSync(BuildContext context, String url) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);

    if (response.Status == 1) {
      final val = json.decode(response.Data);
      SyncResp syncLists = SyncResp.fromJson(val);
      return syncLists;
    } else {
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "Sync Failed");
    }
  }

  static Future<JudgmentDownloadModel> getDownloadData(
      BuildContext context, String url) async {
    CustomResponse response =
        await HttpClientRequest.instance.fetchData(context, url, null);

    if (response.Status == 1) {
      final val = json.decode(response.Data);
      JudgmentDownloadModel pdfData = JudgmentDownloadModel.fromJson(val);
      return pdfData;
    } else {
      Provider.of<GlobalProvider>(context, listen: false)
          .setIsBusy(false, "No Data Found");
    }
  }
}
