import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gank/data/data_sourse.dart';
import 'package:flutter_gank/data/info_entity.dart';
import 'package:flutter_gank/ui/web_page.dart';


class InfoListPage extends StatefulWidget {

  InfoListPage(this._type);

  String _type;

  @override
  State createState() {
    return new InfoListState(_type);
  }
}

class InfoListState extends State<InfoListPage> {

  InfoListState(this._type);

  String _type;

  final int count = 10;

  int _pageIndex = 1;

  List<InfoDetail> _list;

  @override
  Widget build(BuildContext context) {
    return new InfoList(_list);
  }

  @override
  void initState() {
    super.initState();

    print("initState $_type");
    _getInfoList();
  }

  _getInfoList() async {
    var results = await DataSource.getInfoList(_type, count, _pageIndex);
//    print("_getInfoList $results");
    if (!mounted)
      return;
    setState(() {
      _list = results;
    });
  }
}

class InfoList extends StatelessWidget {

  InfoList(this._list);

  List<InfoDetail> _list;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(itemBuilder: (context, index) {
      return new InfoListItem(_list[index]);
    },
      itemCount: _list != null ? _list.length : 0,);
  }
}

class InfoListItem extends StatelessWidget {

  final InfoDetail _infoDetail;

  InfoListItem(this._infoDetail);

  @override
  Widget build(BuildContext context) {
    // "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    var time = DateTime.parse(_infoDetail.publishedAt);

    var image;
    if (_infoDetail.image == null) {
      image = new Image.asset("images/empty.png", height: 40.0,
        width: 40.0,);
    } else {
      image = new CachedNetworkImage(
        height: 40.0,
        width: 40.0,
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Image.asset("images/failpicture.png"),
        imageUrl: _infoDetail.image,);
    }

    return new GestureDetector(child: new Card(
        child: new Row(children: <Widget>[
          image,

          new Expanded(
              child: new Column(children: <Widget>[
                new Text(
                  _infoDetail.desc,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 1,),
                new Row(
                  children: <Widget>[
                    new Text(
                        _infoDetail.who != null ? _infoDetail.who : "unkown"),
                    new Text("${time.year}/${time.month}/${time.day}"),
                    new Image.asset("images/arrow_right.png")
                  ], mainAxisSize: MainAxisSize.min,)
              ])),

        ],)
    ),
      onTap: () {
        Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) {
              return new WebPage(_infoDetail.url, _infoDetail.desc);
            }));
      },);
  }

}