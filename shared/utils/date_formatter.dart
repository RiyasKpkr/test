import 'package:intl/intl.dart';

class DateFormatter {
  static String formatToLocaleTime(String? datetimeTxt) {
    if (datetimeTxt == null) return "";

    DateTime dateTime = DateTime.parse(datetimeTxt);
    DateTime localDateTime = dateTime.toLocal();
    String formattedDateTime = DateFormat('hh:mm a').format(localDateTime);
    return formattedDateTime;
  }

  static String setDateFieldTxt(dynamic datetime) {
    if (datetime == null) return "";

    DateTime dateTime = DateTime.parse("$datetime");
    DateTime localDateTime = dateTime.toLocal();
    String formattedDateTime = DateFormat('dd MMM yyyy').format(localDateTime);
    return formattedDateTime;
  }

  static String getFormattedTxt(String? datetimeTxt, {String? format}) {
    if (datetimeTxt == null) return "";

    DateTime dateTime = DateTime.parse(datetimeTxt).toLocal();
    String formattedDateTime = DateFormat(format ?? 'MMMM yyyy').format(dateTime);
    return formattedDateTime;
  }

  static String attendanceYearAndMonth(String? datetimeTxt) {
    if (datetimeTxt == null) return "";

    DateTime dateTime = DateTime.parse(datetimeTxt).toLocal();
    String formattedDateTime = DateFormat('yyyy-MM').format(dateTime);
    return formattedDateTime;
  }

  static String attendanceDay(String? datetimeTxt) {
    if (datetimeTxt == null) return "";

    DateTime dateTime = DateTime.parse(datetimeTxt).toLocal();
    String formattedDateTime = DateFormat('MMM dd').format(dateTime);
    return formattedDateTime;
  }

  static String formatToDateTime(String? datetimeTxt) {
    if (datetimeTxt == null) return "";

    DateTime dateTime = DateTime.parse(datetimeTxt);
    DateTime localDateTime = dateTime.toLocal();
    String formattedDateTime = DateFormat('MMMM d, y | hh:mm a').format(localDateTime);
    return formattedDateTime;
  }

  static String getCurrentTime() {
    DateTime dateTime = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();
    String formattedDateTime = DateFormat('hh:mm a').format(localDateTime);
    return formattedDateTime;
  }

  static String getCurrentDateTime() {
    DateTime dateTime = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();
    String formattedDateTime = DateFormat('MMMM d, y | hh:mm a').format(localDateTime);
    return formattedDateTime;
  }

  static String getYearTxt(String? datetimeTxt) {
    DateTime dateTime = datetimeTxt != null ? DateTime.parse(datetimeTxt) : DateTime.now().toLocal();
    String formattedDateTime = DateFormat('yyyy').format(dateTime);
    return formattedDateTime;
  }

  static String convertToServerDateFormat(DateTime dateTime) {
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return "${formattedDateTime}T00:00:00.000Z";
  }

  static DateTime? convertServerDateTimeStringToDateTime(String? datetimeTxt) {
    if (datetimeTxt == null) return null;

    DateTime dateTime = DateTime.parse(datetimeTxt);
    DateTime localDateTime = dateTime.toLocal();
    return localDateTime;
  }
}
