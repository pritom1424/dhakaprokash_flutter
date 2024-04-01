import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  String defaultFormatWithTime(DateTime dateTime) {
    return DateFormat("d MMMM, yyyy| hh:mm a", 'bn').format(dateTime);
  }

  String defaultFormat(DateTime dateTime) {
    return DateFormat("d MMMM, yyyy", 'bn').format(dateTime);
  }
}
