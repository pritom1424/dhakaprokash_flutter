import 'package:flutter/material.dart';

class ScrollControl {
  void customscrollListener(
      ScrollController scrollController, int? timeInMili) {
    double currentScrollOffset = scrollController.offset;
    double? lastScrollOffset;
    if (currentScrollOffset <= (lastScrollOffset ?? 0.0)) {
      _slowScrollDown(lastScrollOffset ?? 0.0, scrollController, timeInMili);
    } else {
      lastScrollOffset = currentScrollOffset;
      lastScrollOffset += 300;
    }
  }

  void _slowScrollDown(
      double lastScOffset, ScrollController scrollController, int? timeMili) {
    double maxScrollExtent = scrollController.position.maxScrollExtent;

    if (lastScOffset > maxScrollExtent) {
      lastScOffset = maxScrollExtent;
    } else {
      scrollController.animateTo(
        lastScOffset,
        duration: Duration(
            milliseconds: timeMili ?? 5000), // Adjust duration as needed
        curve: Curves.easeInToLinear,
      );
    }
  }
}
