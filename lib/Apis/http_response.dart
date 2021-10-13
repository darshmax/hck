import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hck_case_management/Apis/api_response.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:http/http.dart' as http;
import 'api_base.dart';
import 'package:provider/provider.dart';

class HttpClientRequest {
  static final HttpClientRequest _singleton = HttpClientRequest();

  static HttpClientRequest get instance => _singleton;

  Future<CustomResponse> fetchData(BuildContext context, String url, dynamic body, {Map<String, String> params}) async {
    context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(true, null) : print("context null");
    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");
    print("url: " + uri);
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      http.Response response;
      if(body == null){
        response = await http.get(Uri.parse(uri), headers: header);
      }else{
        response = await http.post(Uri.parse(uri), headers: header, body: body);
      }

      //print(response.body);
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, null): print("c null");
      if(response.statusCode == 200){
        //print(response.body);
        return CustomResponse(Error: null, Data: response.body, Status: 1);
      }else{
        String error = response.statusCode.toString() + " : " + response.body;
        return CustomResponse(Error: error, Data: null, Status: 0);
      }

    }catch(e){
      context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, e.toString()): print("c null");
      return CustomResponse(Error: e.toString(), Data: null, Status: 0);
    }
    return null;
    
  }

  String queryParameters(Map<String, String> params) {
    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }



}
