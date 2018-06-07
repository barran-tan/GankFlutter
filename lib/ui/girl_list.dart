import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/data/data_sourse.dart';
import 'package:flutter_gank/data/info_entity.dart';

class GirlList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GirlListState();
  }

}

class GirlListState extends State<GirlList> {

  List<String> _list;

  int _page;

  @override
  void initState() {
    super.initState();

    _getGirlList();
  }

  _getGirlList() async {
    var results = await DataSource.getInfoList(
        DataSource.getNameByType(InfoType.welfare), 20, _page);
//    print("_getInfoList $results");
    if (!mounted)
      return;

    var list = new List<String>();
    results.forEach((info) {
      if (info.url != null) {
        list.add(info.url);
      }
    });
    print("_getGirlList ${list.length}");
    setState(() {
      _list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('妹子'),
        ),
        body: new ListView.builder(itemBuilder: (context, index) {
          return new CachedNetworkImage(
            placeholder: new CircularProgressIndicator(),
            errorWidget: new Image.asset("images/failpicture.png"),
            imageUrl: _list[index],);
        },
          itemCount: _list != null ? _list.length : 0,),

      ),
    );
  }

}