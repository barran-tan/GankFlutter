import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GirlList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GirlListState();
  }

}

class GirlListState extends State<GirlList> {

  List<String> _list;


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('history list'),
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