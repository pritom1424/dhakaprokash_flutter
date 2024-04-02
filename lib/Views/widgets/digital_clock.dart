import 'package:dummy_app/Utils/bangla_calendar/bongabdo.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class DigitalClockWidget extends StatelessWidget {
  const DigitalClockWidget({super.key});

  String getSystemTime() {
    var now = DateTime.now();
    String dateString = DateFormat(null, "Bn").add_jms().format(now);
    dateString = timeName(now) +
        " " +
        dateString.replaceAll(
            RegExp(r'\b(?:AM|PM)\b', caseSensitive: false), '');
    return dateString;
  }

  String timeName(DateTime dt) {
    double dateNumber = dt.hour + (dt.minute / 60);

    switch (dateNumber) {
      case >= 5 && < (5 + (59 / 60)):
        return "ভোর";
      case >= 6 && < (11 + (59 / 60)):
        return "সকাল";
      case >= 12 && < (14 + (59 / 60)):
        return "দুপুর";
      case >= 15 && < 18:
        return "বিকাল";
      case >= 18 && < 20:
        return "সন্ধ্যা";

      default:
        return "রাত";
    }
  }

  @override
  Widget build(BuildContext context) {
    String banglaDate =
        "${Bongabdo.fromDate(DateTime.now()).bDay}-${Bongabdo.fromDate(DateTime.now()).bMonth}-${Bongabdo.fromDate(DateTime.now()).bYear}";

    String englishDate = DateFormat.yMMMMEEEEd("Bn").format(DateTime.now());
    return TimerBuilder.periodic(Duration(seconds: 1), builder: (ctx) {
      return Container(
        color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              englishDate + " | " + banglaDate,
              style: TextStyle(
                  fontFamily: 'SolaimanLipi',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "${getSystemTime()}",
              style: TextStyle(
                  fontFamily: 'SolaimanLipi',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    });
  }
}
