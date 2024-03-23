import 'package:intl/intl.dart';

class DateFormatter {
  String defaultFormatWithTime(DateTime dateTime) {
    return DateFormat("d MMM, yyyy| hh:mm a").format(dateTime);
  }

  String defaultFormat(DateTime dateTime) {
    return DateFormat("d MMM, yyyy").format(dateTime);
  }
}
