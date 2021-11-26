import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/select_item.dart';

class Util {
  String convertData(int timestamp) {
    final df = DateFormat('yyyy年MM月dd日 hh時mm分');
    return df.format(DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000));
  }

  Color getColor(int c_id, List<SelectItem> menus) {
    SelectItem data = menus.firstWhere(
      (element) => element.id == c_id,
    );
    if (data.color == 'blue') {
      return Colors.blue;
    }
    if (data.color == 'yellow') {
      return Colors.deepOrangeAccent;
    }
    if (data.color == 'green') {
      return Colors.green;
    }
    if (data.color == 'gray') {
      return Colors.black38;
    }
    if (data.color == 'red') {
      return Colors.red;
    }
    if (data.color == 'purple') {
      return Colors.purple;
    }
  }
}
