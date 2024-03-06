import 'dart:convert';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostController with ChangeNotifier {
  List<PostModel> _items = [];
  List<PostModel> visibleItems = [];
  int visibleItemCount = 5;
  bool showButton = false;

  Future<void> loadItems() async {
    final uri = Uri.http("jsonplaceholder.typicode.com", "/posts");
    final response = await http.get(uri);

    final jsonMap = json.decode(response.body);

    _items = (jsonMap as List).map((itm) => PostModel.fromJson(itm)).toList();
    getVisibileItems();
  }

  Future<void> loadAllItems() async {
    final uri = Uri.http("jsonplaceholder.typicode.com", "/posts");
    final response = await http.get(uri);

    final jsonMap = json.decode(response.body);

    _items = (jsonMap as List).map((itm) => PostModel.fromJson(itm)).toList();
  }

  List<PostModel> get Items {
    return _items;
  }

  void getVisibileItems() {
    visibleItems = [];
    if (visibleItemCount >= _items.length) {
      visibleItemCount = _items.length;
      showButton = false;
    } else {
      showButton = true;
    }
    visibleItems
        .addAll(List.generate(visibleItemCount, (index) => _items[index]));
  }

  void loadMoreItems() {
    visibleItemCount += 20;
    getVisibileItems();

    notifyListeners();
  }
}
