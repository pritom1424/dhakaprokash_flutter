import 'package:intl/intl.dart';

class DateFormatter {
  String defaultFormatWithTime(DateTime dateTime) {
    String formatString = DateFormat("hh:mm a, d MMMM, yyyy", 'bn')
        .format(dateTime)
        .replaceAll("AM", "এএম")
        .replaceAll("PM", "পিএম");
    return formatString;
  }

  String defaultFormat(DateTime dateTime) {
    return DateFormat("d MMMM, yyyy", 'bn').format(dateTime);
  }
}
