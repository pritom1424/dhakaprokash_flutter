import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokash_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomepageController with ChangeNotifier {
  List<DhakaProkash> _items = [];
  Future<List<DhakaProkash>> loadAllItems() async {
    final url = Uri.parse(
        "https://dhakaprokash24.com/api/prismaapi/home/specialtopcontent");

    final response = await http.get(url);
    print(response);
    List<DhakaProkash> jsonResponse =
        dhakaProkashFromJson(utf8.decode(response.bodyBytes));

    _items = jsonResponse;
    // notifyListeners();

    return jsonResponse;
  }

  List<DhakaProkash> get Items {
    return _items;
  }
}
