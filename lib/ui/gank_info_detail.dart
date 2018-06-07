import 'package:flutter/material.dart';
import 'package:flutter_gank/data/data_sourse.dart';
import 'package:flutter_gank/data/info_entity.dart';
import 'package:flutter_gank/ui/gank_info_list.dart';


class DailyInfo extends StatefulWidget {

  DailyInfo(this._date);

  DateTime _date;

  @override
  State<StatefulWidget> createState() {
    return new DailyInfoState(_date);
  }

}

class DailyInfoState extends State<DailyInfo> {

  DailyInfoState(this._date);

  DateTime _date;

  List<InfoDetail> _infoList;

  String image;

  @override
  void initState() {
    super.initState();

    _infoList = new List();

    _getDailyInfo();
  }

  _getDailyInfo() async {
    var results = await DataSource.getDailyInfo(
        _date.year, _date.month, _date.day);
//    print("_getDailyInfo $results");
    if (!mounted)
      return;

    var welfare = DataSource.getNameByType(InfoType.welfare);
    results.forEach((key, list) {
      if (welfare == key) {
        image = list.first.url;
      } else {
        // add empty info as group
        _infoList.add(new InfoDetail.empty(key));

        _infoList.addAll(list);
      }
    });
    print("_getDailyInfo ${_infoList.length}");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("${_date.year}/${_date.month}/${_date.day}"),
        ),
        body: new ListView.builder(itemBuilder: (context, index) {
          var info = _infoList[index];
          if (info.url == null) {
            return new TypeItem(info.type);
//            return new Divider();
          } else {
            return new InfoListItem(info);
          }
        },
          itemCount: _infoList.length,),

      ),
    );
  }

}

class TypeItem extends StatelessWidget {

  String _type;

  TypeItem(this._type);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(_type),);
  }

}