import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokash_recent_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RecentPageController with ChangeNotifier {
  Future<List<DhakaProkashRecentModel>> loadRecentPosts(int itmCount) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/collection/latestpost");

    Map data = {"take": itmCount, "skip": 0};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    List<DhakaProkashRecentModel> jsonResponse =
        dhakaProkashRecentModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }
}
