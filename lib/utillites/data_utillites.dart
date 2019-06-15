import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

String parseHumanDateTime(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDiffrence = DateTime.now().subtract(timeAgo);
    return timeago.format(theDiffrence);
  }

Widget error(var error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Text(
        error.toString(),
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget noData() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Text(
        'No Data Available!',
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget connectionError() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Text(
        'Connection Error!',
        textAlign: TextAlign.center,
      )),
    );
  }