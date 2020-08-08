import 'dart:convert';
import 'package:covid_app/model/global_report.dart';
import 'package:covid_app/utils/in_case_500_data.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<GlobalReport> getGlobalReport() => http.get('https://api.covid19api.com/summary')
      .then((value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          return GlobalReport.fromJson(json.decode(value.body));
        }
        return GlobalReport.fromJson(inCase500APIData);
  }).timeout(Duration(seconds: 8), onTimeout: () => GlobalReport.fromJson(inCase500APIData));
}