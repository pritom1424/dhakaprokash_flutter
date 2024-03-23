import 'package:flutter/material.dart';

class ScrollControl with ChangeNotifier {
  double getControllerOffset(ScrollController scrollController) {
    if (scrollController.hasClients) {
      notifyListeners();
      return scrollController.offset;
    }
    notifyListeners();
    return 0.0;
  }
}
