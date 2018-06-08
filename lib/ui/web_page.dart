import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatelessWidget {

  final String _url;

  String _title;

  WebPage(this._url, this._title);

  @override
  Widget build(BuildContext context) {
    if (_title == null) {
      _title = 'webview';
    }
    return new WebviewScaffold(
      url: _url,
      appBar: new AppBar(
        title: new Text(_title),
      ),
    );
  }

}