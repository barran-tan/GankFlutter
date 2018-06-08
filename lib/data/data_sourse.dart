import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_gank/data/info_entity.dart';


class DataSource {

  static const String base_url = 'http://gank.io/';

  List<InfoDetail> detailList;

  static Future<List<InfoDetail>> getInfoList(String type, int pageCount,
      int pageNum) async {
    final response = await http.get(
        base_url + "api/data/$type/$pageCount/$pageNum");
//    print("getInfoList:\n ${response.body}");
    final result = json.decode(response.body);

    return new DataResponse.fromJson(result).results;
  }

  static Future<List<String>> getDateList() async {
    final response = await http.get(
        base_url + "api/day/history");
//    print("getDateList:\n ${response.body}");
    final result = json.decode(response.body);

    return new HistoryResponse.fromJson(result).results;
  }

  static Future<Map<String, List<InfoDetail>>> getDailyInfo(int year, int month,
      int day) async {
    final response = await http.get(
        base_url + "api/day/$year/$month/$day");
//    print("getDailyInfo:\n ${response.body}");
    final result = json.decode(response.body);

    return new DailyDataResponse.fromJson(result).results;
  }

  static String getNameByType(InfoType type) {
    switch (type) {
      case InfoType.all :
        return "全部";
      case InfoType.android:
        return "Android";
      case InfoType.ios:
        return "IOS";
      case InfoType.past_time:
        return "休息视频";
      case InfoType.welfare:
        return "福利";
      case InfoType.expand_information:
        return "拓展资源";
      case InfoType.front_end:
        return "前端";
      case InfoType.recommend:
        return "瞎推荐";
      case InfoType.app:
        return "APP";
      default:
        return "未分类";
    }
  }
}
