import 'dart:convert';

import 'package:dummy_app/Models/dhak_prokash_tab_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_photo_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_sp_model.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomepageController with ChangeNotifier {
  List<DhakaProkashSpecialModel> _items = [];

  int photoShowNumber = 4;
  bool isButtonVisible = true;

  Future<List<DhakaProkashSpecialModel>> loadAllSpItems() async {
    final url = Uri.parse(ApiConstant.homePageSpecialContentLink);

    final response = await http.get(url);

    List<DhakaProkashSpecialModel> jsonResponse =
        dhakaProkashSpecialModelFromJson(utf8.decode(response.bodyBytes)); //

    _items.clear();
    _items = jsonResponse;

    // notifyListeners();

    return jsonResponse;
  }

  Future<List<DhakaProkashRegularModel>> loadAllRegItems(String apiLink) async {
    final url = Uri.parse(apiLink);

    final response = await http.get(url);

    List<DhakaProkashRegularModel> jsonResponse =
        dhakaProkashRegularModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<List<DhakaProkashRegularModel>> loadAllRegItemsPost(
      String apiLink, int itemNum) async {
    final url = Uri.parse(apiLink);
    print("Post Api Called");
    Map data = {"take": itemNum};

    final response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json'
    } //{"Content-Type": "application/x-www-form-urlencoded"},
        );
    print("Post Api response: ${utf8.decode(response.bodyBytes)}");
    List<DhakaProkashRegularModel> jsonResponse =
        dhakaProkashRegularModelFromJson(utf8.decode(response.bodyBytes));
    print("Post Api debug");
    print(jsonResponse);

    return jsonResponse;
  }

  Future<List<DhakaProkashPhotoModel>> loadAllPhotoItems() async {
    final url = Uri.parse(ApiConstant.photoGalleryCategoryLink);

    final response = await http.get(url);

    List<DhakaProkashPhotoModel> jsonResponse =
        dhakaProkashPhotoModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  List<DhakaProkashSpecialModel> get Items {
    return _items;
  }

  void addMorePhotos(int totalPhotoNum) {
    if (totalPhotoNum < photoShowNumber) {
      isButtonVisible = false;
      notifyListeners();
    } else if (totalPhotoNum == photoShowNumber + 4) {
      photoShowNumber += 4;


      notifyListeners();
    } else if (totalPhotoNum < photoShowNumber + 4 &&
        totalPhotoNum > photoShowNumber) {
      photoShowNumber = totalPhotoNum;

      isButtonVisible = false;
      notifyListeners();
    }
    photoShowNumber += 4;

    isButtonVisible = true;
    notifyListeners();
  }

  bool get IsMoreButtonVisible {
    return isButtonVisible;
  }
}
