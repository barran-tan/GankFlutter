import 'package:flutter/material.dart';
import 'package:flutter_gank/ui/gank_date_list.dart';
import 'package:flutter_gank/ui/gank_info_list.dart';
import 'package:flutter_gank/ui/girl_list.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false;
  runApp(new TabbedAppBarSample());
}


class TabbedAppBarSample extends StatelessWidget {

  final list = ["Android", "休息视频", "拓展资源", "前端", "瞎推荐"];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: list.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text('GankFlutter'),
            bottom: new TabBar(
              isScrollable: true,
              tabs: list.map((String type) {
                return new Tab(
                  text: type,
                );
              }).toList(),
            ),
            actions: <Widget>[
              new Builder(
                  builder: (BuildContext context) {
                    return new IconButton(
                        icon: new Icon(Icons.history), onPressed: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) {
                          return new DateList();
                        })
                        ,
                      );
                    });
                  }),
            ],
          ),
          body: new TabBarView(
            children: list.map((String type) {
              return new InfoListPage(type);
            }).toList(),
          ),

          floatingActionButton: new Builder(builder: (context) {
            return new FloatingActionButton(
                child: new Image.asset("images/girl.png"),
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) {
                        return new GirlList();
                      }));
                });
          }),
        ),
      ),
    );
  }
}
