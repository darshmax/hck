import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String initUrl;

  const WebViewPage({Key key, this.title, this.initUrl}) : super(key: key);
  @override
  WebViewPageState createState() => WebViewPageState(this.title,this.initUrl);
}
class WebViewPageState extends State<WebViewPage> {
  final String title;
  final String initUrl;
  WebViewController mWebViewController;
  double progress = 0;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  WebViewPageState(this.title, this.initUrl,);
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: [

          WebView(

            initialUrl: initUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){

              _controller.complete(webViewController);
              mWebViewController = webViewController;
            },
            onProgress: (int prog){
              setState(() {
                progress = prog / 100;
              });
              print("loading $progress");
            },
            onPageStarted: (String url){
              print("page started loading: $url");
            },
            onPageFinished: (String url){
              print("page finished loading: $url");
            },
          ),
          progress < 1 ? LinearProgressIndicator(value: progress,color: Colors.blue,) : Container(),
          Center(
            child: progress < 1 ?  CupertinoActivityIndicator() : SizedBox.shrink(),
          )

        ],
      ),
    );
  }
}

