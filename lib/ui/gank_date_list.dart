import 'package:flutter/material.dart';
import 'package:flutter_gank/data/data_sourse.dart';
import 'package:flutter_gank/ui/gank_info_detail.dart';

class DateList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DateListState();
  }

}

class DateListState extends State<DateList> {

  List<String> _list;

  @override
  void initState() {
    super.initState();

    _getDateList();
  }

  _getDateList() async {
    var results = await DataSource.getDateList();
    print("_getDateList ${results.length}");
    if (!mounted)
      return;
    setState(() {
      _list = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('history list'),
        ),
        body: new ListView.builder(itemBuilder: (context, index) {
          return new DateListItem(_list[index]);
        },
          itemCount: _list != null ? _list.length : 0,),

      ),
    );
  }

}

class DateListItem extends StatelessWidget {

  DateListItem(this._date);

  String _date;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(child: new Card(child: new Padding(
      padding: new EdgeInsets.only(
          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: new Text(_date),),),
      onTap: () {
        Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) {
              DateTime time = DateTime.parse(_date);
              return new DailyInfo(time);
            }));
      },);
  }
}