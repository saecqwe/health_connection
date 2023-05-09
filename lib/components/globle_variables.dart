import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GetStorage storage = GetStorage();
const String appIcon = "assets/icons/icon.png";
getDate<String>(date) {
  if (date == null) {
    return null;
  } else {
    var outputFormat = DateFormat('dd-MMM-yyyy');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }
}

getDateTime<String>(date) {
  if (date == null) {
    return null;
  } else {
    var outputFormat = DateFormat('dd-MMM-yyyy - hh:mm a');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }
}

getDateFormTimeStamp<String>({required date, format}) {
  if (date == null) {
    return null;
  } else {
    var dateData =
        DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
    var outputFormat = DateFormat(format ?? 'dd-MMM-yyyy');
    var outputDate = outputFormat.format(dateData);
    return outputDate;
  }
}

getTimeFormTimeStamp<String>({required date, format}) {
  if (date == null) {
    return null;
  } else {
    if (date.runtimeType == int) {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(date);
      var outputFormat = DateFormat(format ?? 'dd-MMM-yyyy - hh:mm a');
      var outputDate = outputFormat.format(dateTime);
      return outputDate;
    } else {
      var dateData =
          DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
      var outputFormat = DateFormat(format ?? 'dd-MMM-yyyy - hh:mm a');
      var outputDate = outputFormat.format(dateData);
      return outputDate;
    }
  }
}

convertDateTime(date) {
  if (date == null) {
    return null;
  } else {
    if (date.runtimeType == int) {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(date);

      return dateTime;
    } else if (date.runtimeType == int) {
      return date;
    } else {
      var dateData =
          DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);

      return dateData;
    }
  }
}

saveDateTime<int>(date) {
  if (date == null) {
    return null;
  } else {
    var dateData =
        DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);

    var timestamp = dateData.millisecondsSinceEpoch;

    return timestamp;
  }
}

basicStyle(
    {double? size, Color? color, FontWeight? fontWeight, double? height}) {
  return TextStyle(
      fontSize: size ?? 24,
      color: color,
      fontWeight: fontWeight,
      height: height);
}

getSavedTimeStamp<String>({required date, format}) {
  if (date == null) {
    return null;
  } else {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);

    var outputFormat = DateFormat(format ?? 'dd-MMM-yyyy - hh:mm a');
    var outputDate = outputFormat.format(dateTime);
    return outputDate;
  }
}

pushPage({required String pageName, dynamic argument}) {
  return Navigator.of(navigatorKey.currentContext!)
      .pushNamed(pageName, arguments: argument);
}

pushPageAsWidget({required Widget pageName, dynamic argument}) {
  Navigator.of(navigatorKey.currentContext!)
      .push(MaterialPageRoute(builder: (context) => pageName));
}

backPage() {
  Navigator.pop(navigatorKey.currentContext!);
}

pushAndoffUntilWidget(Widget pageName) {
  Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => pageName),
      (Route<dynamic> route) => false);
}
