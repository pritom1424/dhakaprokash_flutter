import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokash_photo_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_sp_model.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomepageController with ChangeNotifier {
  List<DhakaProkashSpecialModel> _items = [];

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
}
