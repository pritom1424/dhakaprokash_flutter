import 'package:flutter/material.dart';

class CategoryViewController with ChangeNotifier {
  int totalShowNumber = 10;
  bool isButtonVisible = false;

  void addMoreItems(int totalItmNum) {
    if (totalItmNum < totalShowNumber) {
      isButtonVisible = false;
      notifyListeners();
    } else if (totalItmNum == totalShowNumber + 4) {
      totalShowNumber += 4;

      notifyListeners();
    } else if (totalItmNum < totalShowNumber + 4 &&
        totalItmNum > totalShowNumber) {
      totalItmNum = totalShowNumber;

      isButtonVisible = false;
      notifyListeners();
    }
    totalShowNumber += 4;

    isButtonVisible = true;
    notifyListeners();
  }

  int get TotalShowNumber {
    return totalShowNumber;
  }
}
