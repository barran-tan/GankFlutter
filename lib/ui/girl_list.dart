import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/data/data_sourse.dart';
import 'package:flutter_gank/data/info_entity.dart';
import 'package:flutter_gank/refresh/Refresh.dart';
import 'dart:async' show Future;

class GirlList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GirlListState();
  }

}

class GirlListState extends State<GirlList> {

  List<String> _list = new List();

  int _page = 1;

  final int _pageCount = 10;

  bool _hasMore = true;

  @override
  void initState() {
    super.initState();

    _getGirlList();
  }

  Future<Null> _getGirlList() async {
    var results = await DataSource.getInfoList(
        DataSource.getNameByType(InfoType.welfare), _pageCount, _page);
    print("_getGirlList $_page");
    if (!mounted || results == null)
      return;

    var list = new List<String>();
    results.forEach((info) {
      if (info.url != null) {
        list.add(info.url);
      }
    });
    if (results.isEmpty || results.length < _pageCount) {
      _hasMore = false;
    }
    print("_getGirlList ${list.length}");
    setState(() {
      _list.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('妹子'),
          leading: new IconButton(icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: RefreshLayout(
            canloading: _hasMore,
            canrefresh: true,
            onRefresh: (boo) {
              if (!boo) {
                _page ++;
                return _getGirlList();
              } else {
                _page = 0;
                _list.clear();
                return _getGirlList();
              }
            },
            child: new ListView.builder(itemBuilder: (context, index) {
              return new CachedNetworkImage(
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Image.asset("images/failpicture.png"),
                imageUrl: _list[index],);
            },
              itemCount: _list.length,)),

      ),
    );
  }

}