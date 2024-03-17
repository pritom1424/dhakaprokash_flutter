import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokash_data.dart';
import 'package:http/http.dart' as http;

class HomepageController {
  List<DhakaProkash> _items = [];
  Future<List<DhakaProkash>> loadAllItems() async {
    final url = Uri.parse(
        "https://dhakaprokash24.com/api/prismaapi/home/specialtopcontent");

    final response = await http.get(url);
    // print(response);
    List<DhakaProkash> jsonResponse =
        dhakaProkashFromJson(utf8.decode(response.bodyBytes));

    print(jsonResponse);

    return jsonResponse;
  }
}
