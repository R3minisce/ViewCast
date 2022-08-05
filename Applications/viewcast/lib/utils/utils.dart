class Utils {
  static String formatMonth(DateTime date) {
    String month = date.month.toString();
    if (month.length == 1) month = "0" + month;
    return month;
  }

  static String formatMinute(DateTime date) {
    String minute = date.minute.toString();
    if (minute.length == 1) minute = "0" + minute;
    return minute;
  }
}
