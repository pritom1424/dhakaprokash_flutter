import 'dart:convert';
import 'package:dummy_app/Models/dhaka_prokash_cat_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_photo_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_sp_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_vid_model.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomepageController with ChangeNotifier {
  List<DhakaProkashSpecialModel> _items = [];
  List<DhakaProkashPhotoModel> _photoes = [];
  int photoShowNumber = 4;
  bool isButtonVisible = true;

  DhakaprokashCatModel? _dhakaprokashCatModel;

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

  Future<List<DhakaProkashRegularModel>> loadAllRegTabItemsPost(
      String apiLink, int itemNum) async {
    final url = Uri.parse(apiLink);

    Map data = {"take": itemNum};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    List<DhakaProkashRegularModel> jsonResponse =
        dhakaProkashRegularModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<DhakaprokashCatModel> loadAllRegCatItemsPost(
      String catSlug, int itemNum) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/category/categorycontent");

    Map<String, dynamic> data = {
      "cat_slug": catSlug,
      "take": itemNum,
      "skip": 0
    };

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DhakaprokashCatModel jsonResponse =
        dhakaprokashCatModelFromJson(utf8.decode(response.bodyBytes));

    _dhakaprokashCatModel = jsonResponse;

    return jsonResponse;
  }

  Future<List<DhakaProkashPhotoModel>> loadAllPhotoItems() async {
    final url = Uri.parse(ApiConstant.photoGalleryCategoryLink);

    final response = await http.get(url);

    List<DhakaProkashPhotoModel> jsonResponse =
        dhakaProkashPhotoModelFromJson(utf8.decode(response.bodyBytes));

    _photoes = jsonResponse;

    return jsonResponse;
  }

  Future<List<int>> loadHomeVideosPost(int itemNum) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/home/videofeature");

    List<int> ids = [];

    Map<String, dynamic> data = {
      "take": itemNum,
    };

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    List<DhakaprokashVidModel> jsonResponse =
        dhakaprokashVidModelFromJson(utf8.decode(response.bodyBytes));

    GenericVars.getVideoData.clear();

    GenericVars.getVideoData = List.generate(jsonResponse.length, (index) {
      ids.add(jsonResponse[index].id);
      return {
        "title": jsonResponse[index].title,
        "category": GenericVars.newspaperCategoriesLink.keys.firstWhere(
            (element) =>
                GenericVars.newspaperCategoriesLink[element] ==
                jsonResponse[index].slug),
        "url": "https://www.youtube.com/watch?v=${jsonResponse[index].code}"
      };
    });
    return ids;
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

  List<DhakaProkashPhotoModel> get photoes => _photoes;
  DhakaprokashCatModel? get catModels => _dhakaprokashCatModel!;
}
