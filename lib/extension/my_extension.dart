import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension View on num {
  Widget get height => SizedBox(height: toDouble().h);

  Widget get width => SizedBox(width: toDouble().w);
}

extension View2 on Widget {
  Widget get start => Align(
        alignment: Alignment.centerLeft,
        child: this,
      );

  Widget get end => Align(
        alignment: Alignment.centerRight,
        child: this,
      );
}

extension View3 on DateTime {
  String get time => DateFormat('h:mm a').format(this);

  String get date => DateFormat('dd-MM-yyyy').format(this);

  String get dayName => DateFormat('E').format(this);

  String get checkTime {
    DateTime currentDateTime = DateTime.now();

    Duration difference = currentDateTime.difference(this);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return ("${difference.inMinutes} minutes ago");
      } else {
        return ("${difference.inHours} hours ago");
      }
    } else {
      var createdAtTime = this.toIso8601String().split(".")[0];
      var date = createdAtTime.split("T")[0];
      var time = createdAtTime.split("T")[1];
      return "$date at $time";
    }
  }
}
