import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppImages {
  static const _folderPath = 'assets';
  static const String icSearch = _folderPath + '/ic_search.png';
  static const String img1 = _folderPath + '/img_1.png';
  static const String img2 = _folderPath + '/img_2.png';
  static const String img3 = _folderPath + '/img_3.png';
  static const String img4 = _folderPath + '/img_4.png';
  static const String img5 = _folderPath + '/img_5.png';
  static const String imgGlobal = _folderPath + '/img_global.png';
  static const String imgUs = _folderPath + '/img_us.png';
  static const String imgVn = _folderPath + '/img_vietnam.png';
  static const List<String> otherList = [img1, img2, img3, img4, img5];
}

class AppColors {
  static const red = const Color(0xffBC3737);
  static const white = const Color(0xffffffff);
  static const grey = const Color(0xffF5F5F5);
  static const green = Colors.green;
}

extension NumberFormatExtension on num {
  String get readable {
    final f = NumberFormat("#,###,###");
    int num = int.parse(this.toString().replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = f.format(num);
    return newString;
  }
}