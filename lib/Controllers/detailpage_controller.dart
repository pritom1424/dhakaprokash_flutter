import 'package:flutter/cupertino.dart';

class DetailPageController with ChangeNotifier {
  bool _isCommentClick = false;

  void commentClick() {
    _isCommentClick = true;
    notifyListeners();
  }

  void notCommentClick() {
    _isCommentClick = false;
    notifyListeners();
  }

  bool get IsCommentClick {
    return _isCommentClick;
  }
}
