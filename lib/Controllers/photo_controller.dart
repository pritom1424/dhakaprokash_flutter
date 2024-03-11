import 'dart:collection';
import 'dart:convert';

import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoController with ChangeNotifier {
  List<PhotoModel> _items = [];
  List<PhotoModel> visibleItems = [];
  List<PhotoModel> _searchItems = [];
  // int visibleItemCount = 5;
  bool showButton = false;

  Future<void> loadItems() async {
    final uri = Uri.http("jsonplaceholder.typicode.com", "/photos");
    final response = await http.get(uri);

    final jsonMap = json.decode(response.body);

    _items = (jsonMap as List).map((itm) => PhotoModel.fromJson(itm)).toList();
    getVisibileItems();
  }

  Future<void> loadAllItems() async {
    final uri = Uri.http("api.slingacademy.com", "v1/sample-data/photos");
    //Uri.http("jsonplaceholder.typicode.com", "/photos");
    final response = await http.get(uri);

    final jsonMap = json.decode(response.body);

    _items = (jsonMap['photos'] as List)
        .map((itm) => PhotoModel.fromJson(itm))
        .toList();
  }

  Future<void> loadSearchAllItems(String endPoint) async {
    final uri = Uri.http("api.slingacademy.com", "v1/sample-data/$endPoint");
    //Uri.http("jsonplaceholder.typicode.com", "/photos");
    final response = await http.get(uri);

    final jsonMap = json.decode(response.body);

    _searchItems = (jsonMap['photos'] as List)
        .map((itm) => PhotoModel.fromJson(itm))
        .toList();
  }

  List<PhotoModel> get Items {
    return _items;
  }

  List<PhotoModel> get SearchItems {
    return _searchItems;
  }

  void getVisibileItems() {
    visibleItems = [];
    if (ApiConstant.visibleItemCount >= _items.length) {
      ApiConstant.visibleItemCount = _items.length;
      showButton = false;
    } else {
      showButton = true;
    }
    visibleItems.addAll(
        List.generate(ApiConstant.visibleItemCount, (index) => _items[index]));
  }

  void loadMoreItems() {
    ApiConstant.visibleItemCount += 20;

    getVisibileItems();
    notifyListeners();
  }
}
