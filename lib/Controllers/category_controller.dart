import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokash_detail_photo_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryViewController with ChangeNotifier {
  Future<DetailPhotoModel> loadDetailPhotoItem(int albumId) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/gallery/albumdetail");
    Map data = {"photo_id": albumId};
    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DetailPhotoModel jsonResponse =
        detailPhotoModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }
  /* Future<DetailPhotoModel> loadDetailVideos() async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/gallery/albumdetail");
    Map data = {"photo_id": albumId};
    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DetailPhotoModel jsonResponse =
        detailPhotoModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  } */
  /* int totalShowNumber = 10;
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
  } */
}
