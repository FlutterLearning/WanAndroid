import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'widget/common_bar.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage(this.title, this.url, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebView(title, url);
  }
}

class WebView extends State<WebViewPage> {
  final String title;
  final String url;

  WebView(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
//      appBar: CommonBar(
//        this.title,
//        'WebView'
//      ),
      appBar: AppBar(
        title: Text(this.title),
      ),
      url: url,
    );
  }
}
