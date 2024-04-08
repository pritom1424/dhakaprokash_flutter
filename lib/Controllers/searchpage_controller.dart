import 'package:dummy_app/Models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPageController with ChangeNotifier {
  Future<List<DhakaprokashSearchModel>> loadAllRegSearchItemsPost(
      String keyword, int itemNum) async {
    final url = Uri.parse("https://dhakaprokash24.com/api/v1/search/search");
    print("Post Api Called");
    Map<String, dynamic> data = {
      "keyword": keyword,
      "take": itemNum,
    };

    final response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json'
    } //{"Content-Type": "application/x-www-form-urlencoded"},
        );
    print("Post Api response slug: ${utf8.decode(response.bodyBytes)}");
    List<DhakaprokashSearchModel> jsonResponse =
        dhakaprokashSearchModelFromJson(utf8.decode(response.bodyBytes));
    //dhakaProkashRegularModelFromJson(utf8.decode(response.bodyBytes));
    print("Post Api debug slug");
    print(jsonResponse);

    return jsonResponse;
  }
}
