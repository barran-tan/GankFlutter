import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gank/data/data_sourse.dart';
import 'package:flutter_gank/data/info_entity.dart';
import 'package:flutter_gank/ui/web_page.dart';


class InfoListPage extends StatefulWidget {

  InfoListPage(this._type);

  final String _type;

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

  final List<InfoDetail> _list;

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
      image = new Image.asset("images/empty.png",
        width: 60.0, fit: BoxFit.fitWidth,);
    } else {
      image = new CachedNetworkImage(
        width: 60.0,
        fit: BoxFit.fitWidth,
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Image.asset("images/failpicture.png"),
        imageUrl: _infoDetail.image,);
    }

    return new GestureDetector(child: new Card(
      child: new ListTile(
        //子item的是否为三行
        isThreeLine: false,
        dense: false,
        //左侧图标，不显示则传null
        leading: image,
        //item标题
        title: new Text(
          _infoDetail.desc, maxLines: 3, overflow: TextOverflow.ellipsis,),
        //item内容
        subtitle: new Text(
            "${_infoDetail.who != null ? _infoDetail.who : "unkown"}  ${time
                .year}/${time.month}/${time.day}"),
        //显示右侧的箭头，不显示则传null
        trailing: new Image.asset("images/arrow_right.png", height: 40.0,
          width: 40.0,
          fit: BoxFit.cover,),
      ),

    ),
      onTap: () {
        Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) {
              return new WebPage(_infoDetail.url, _infoDetail.desc);
            }));
      },);
  }

}