import 'package:covid_app/model/country.dart';
import 'package:covid_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'global.dart';
part 'global_report.g.dart';

@JsonSerializable()

class GlobalReport {
  @JsonKey(name: 'Countries')
  final Global global;
  @JsonKey(name: 'Countries')
  final List<CountryReport> countries;


  GlobalReport(this.global, this.countries);

  factory GlobalReport.fromJson(Map<String, dynamic> json) => _$GlobalReportFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalReportToJson(this);

  int get total => (countries?.length ?? 0) + 1;

  List<CountryReport> getDecorDisplayedList() {
    List<CountryReport> displayedList = [];
    displayedList.add(CountryReport('the world', 'GLOBAL', global.totalConfirmed, global.totalDeaths, global.totalRecovered, DateTime.now()));
    displayedList.add(countries.firstWhere((element) => element.countryCode == 'VN'));
    displayedList.add(countries.firstWhere((element) => element.countryCode == 'US'));
    displayedList.addAll(countries.where((element) => element.countryCode != 'VN' && element.countryCode != 'US'));
    return displayedList;
  }

  String getCorrespondingImage(int index) {
    switch (getDecorDisplayedList()[index].countryCode) {
      case 'GLOBAL':
        return AppImages.imgGlobal;
      case 'VN':
        return AppImages.imgVn;
      case 'US':
        return AppImages.imgUs;
      default:
        return AppImages.otherList[ index % 5 ];
    }
  }
}