import 'package:flutter/material.dart';

class VideoProvider with ChangeNotifier {
  bool _isVideoPause = true;
  String _currentVideoLink = "";

  void pauseVideoState() {
    _isVideoPause = true;
    notifyListeners();
  }

  void playVideoState() {
    _isVideoPause = false;
    notifyListeners();
  }

  void setCurrentVideoLink(String url) {
    _currentVideoLink = url;
    print("_currentVideoLink ${_currentVideoLink}");
    notifyListeners();
  }

  String get CurrentVideoLink {
    return _currentVideoLink;
  }

  bool get IsVideoPause {
    return _isVideoPause;
  }
}
