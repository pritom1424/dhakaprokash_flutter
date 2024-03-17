import 'package:dummy_app/Models/dhaka_prokash_data.dart';
import 'package:http/http.dart' as http;

class HomepageController {
  List<DhakaProkash> _items = [];
  Future<http.Response> loadAllItems() async {
    final url = Uri.parse(
        "https://dhakaprokash24.com/api/prismaapi/home/specialtopcontent");

    final response = await http.get(url);

    return response;
  }
}
