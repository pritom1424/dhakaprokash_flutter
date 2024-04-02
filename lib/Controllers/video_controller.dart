import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class VideoProvider with ChangeNotifier {
  bool _isVideoPause = true;
  String _currentVideoLink = "";
  String currentTitle = "";
  bool isLoading = true;

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
    final temp =
        GenericVars.getVideoData.firstWhere((element) => element['url'] == url);
    currentTitle = temp['title']!;
    print("_currentVideoLink ${_currentVideoLink}");
    notifyListeners();
  }

  void changeLoadVideoState() {
    isLoading = !isLoading;
    //notifyListeners();
  }

  String get CurrentVideoLink {
    return _currentVideoLink;
  }

  String get CurrentTitle {
    return currentTitle;
  }

  bool get IsVideoPause {
    return _isVideoPause;
  }

  bool get IsLoading {
    return isLoading;
  }
}
