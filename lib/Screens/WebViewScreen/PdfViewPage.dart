// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// //Working
// void main() {
//   runApp(new hreftest());
// }
//
// class hreftest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: new Text('UrlLauchner'),
//         ),
//         body: new Center(
//           child: new InkWell(
//               child: new Text('View Judgment'),
//               onTap: () => launch('http://karnatakajudiciary.kar.nic.in:8080/app_judgment1.php?data=WP@10@2019@09-09-2019')
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hck_case_management/Models/judgment_download_model.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Widgets/loading_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class PdfViewPage extends StatefulWidget {
  final String pathName;
  final String appbarTitle;

  const PdfViewPage({Key key, this.appbarTitle, this.pathName})
      : super(key: key);
  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<PdfViewPage> with AutomaticKeepAliveClientMixin {
  String pathVal;

  @override
  bool get wantKeepAlive => true;
  @override
  Future<void> initState() {
    pathVal = widget.pathName;
    print("pathVal");
    print(pathVal);
    super.initState();
    //downloadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appbarTitle),
        ),
        body: Stack(
          children: [
            PDFView(
              filePath: pathVal,
            ),

            Consumer<GlobalProvider>(builder: (context, global, child) {
              print(global.error);
              return LoadingScreen(
                isBusy: global.isBusy,
                error: global?.error,
              );
            }),
          ],
        ));
  }
}
