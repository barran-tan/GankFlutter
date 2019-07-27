import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  final String _url;

  final String _title;

  WebPage(this._url, this._title);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  String _title;

  @override
  Widget build(BuildContext context) {
    if (widget._title == null) {
      _title = 'webview';
    } else {
      _title = widget._title;
    }
    return new WebviewScaffold(
      url: widget._url,
      appBar: new AppBar(
        title: new Text(_title),
      ),
    );
  }
}
