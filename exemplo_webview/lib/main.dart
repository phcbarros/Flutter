import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(home: WebViewExample()));

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: WebView(
            initialUrl: 'https://www.github.com/phcbarros',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) => print('Iniciou o carregamento da página $url'),
            onProgress: (int progress) => print('Progresso $progress%'),
            onPageFinished: (String url) => print('Terminou o carregamento da página $url'),
          ),
        ),
      ),
    );
  }
}
