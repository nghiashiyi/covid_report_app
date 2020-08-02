import 'dart:convert';
import 'package:covid_app/model/global_report.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<GlobalReport> getGlobalReport() => http.get('https://api.covid19api.com/summary')
      .then((value) => GlobalReport.fromJson(json.decode(value.body)));
}