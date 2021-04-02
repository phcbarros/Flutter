import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await Permission.storage.request();

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey webviewKey = GlobalKey();

  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useOnDownloadStart: true,
    ),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse('')),
            initialOptions: options,
            onDownloadStart: (InAppWebViewController controller, Uri url) async {
              try {
                print("onDownloadStart $url");
                var base64 = url
                  .toString()
                  .replaceAll('data:application/pdf;base64,', '');

                var bytes = base64Decode(base64.replaceAll('\n', ''));
                final output = await getTemporaryDirectory();
                final file = File("${output.path}/example.pdf");
                await file.writeAsBytes(bytes.buffer.asUint8List());

                print("${output.path}/example.pdf");
                await OpenFile.open('${output.path}/example.pdf', type: 'application/pdf'); 
              } catch (e) {
                print('error');
                print(e);
              }
            }
          ),
        )
      ),
    );
  }
}
