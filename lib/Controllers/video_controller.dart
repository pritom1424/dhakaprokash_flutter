import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokash_all_video_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_single_vid_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_vid_total.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<DhakaProkashVidTotal> getAllVideos() async {
    final url = Uri.parse("https://dhakaprokash24.com/api/v1/video/allvideo");

    final response = await http.get(url);

    DhakaProkashVidTotal jsonResponse =
        dhakaProkashVidTotalFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<DhakaProkashAllVideo> getLatestAllVideos(int amount) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/video/latestvideos");

    /* Map<String, dynamic> data = {"take": amount};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'}); */

    final response = await http.get(url);

    DhakaProkashAllVideo jsonResponse =
        dhakaProkashAllVideoFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<DhakaProkashSingleVideoModel> getSingleVideo(int id) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/video/singlevideo");

    Map<String, dynamic> data = {"id": id};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DhakaProkashSingleVideoModel jsonResponse =
        dhakaProkashSingleVideoModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
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
