class InfoDetail {
  String id;

  String type;

  String createAt;
  String publishedAt;

  String desc;

  String url;

  String who;

  bool used;

  String source;
  List<String> images;

  // custom field
  bool read = false;
  bool favored = false;

  InfoDetail({this.id, this.type, this.createAt, this.publishedAt, this.desc,
    this.url, this.who, this.used, this.source, this.images, this.read, this.favored});

  factory InfoDetail.fromJson(Map<String, dynamic> json) {
    return new InfoDetail(
      id: json['_id'],
      type: json['type'],
      createAt: json['createdAt'],
      publishedAt: json['publishedAt'],
      desc: json['desc'],
      url: json['url'],
      who: json['who'],
      used: json['used'],
      source: json['source'],
      images: json['images'],
    );
  }

}

class DataResponse {
  bool error = false;
  List<InfoDetail> results;

  DataResponse({this.error, this.results});

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    bool error = json['error'];

    if (!error) {
      List<InfoDetail> list = new List();

      for (var item in json['results']) {
        list.add(new InfoDetail.fromJson(item));
      }

      print("DataResponse size ${list.length}");

      return new DataResponse(
          error: error,
          results: list
      );
    } else {
      return null;
    }
  }
}

class HistoryResponse {
  bool error = false;
  List<String> results;

  HistoryResponse({this.error, this.results});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    bool error = json['error'];
    if (!error) {
      List<String> results = json['results'];

      print("HistoryResponse size ${results.length}");

      return new HistoryResponse(
          error: error,
          results: results
      );
    } else {
      return null;
    }
  }
}

class DailyDataResponse {

  List<String> category;
  bool error = false;
  Map<String, List<InfoDetail>> results;

  DailyDataResponse({this.category, this.error, this.results});

  factory DailyDataResponse.fromJson(Map<String, dynamic> json) {
    bool error = json['error'];

    if (!error) {
      Map<String, List<InfoDetail>> results = new Map();

      var keys = json['results'].keys;
      print("jeys $keys");
      for (String key in keys) {
        List<InfoDetail> itemList = new List();
        for (var item in json['results'][key]) {
          itemList.add(new InfoDetail.fromJson(item));
        }

        results[key] = itemList;

        print("key@$key, itemList size ${itemList.length}");
      }

      return new DailyDataResponse(
          category: json['category'],
          error: error,
          results: results
      );
    } else {
      return null;
    }
  }
}

enum InfoType {
  all,
  android,
  ios,
  past_time,
  welfare,
  expand_information,
  front_end,
  recommend,
  app
}
