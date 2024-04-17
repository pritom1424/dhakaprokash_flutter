import 'dart:convert';

import 'package:dummy_app/Models/dhaka_prokahs_detail_post_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_author_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_details_more.dart';
import 'package:dummy_app/Models/dhaka_prokash_tag_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DetailPageController with ChangeNotifier {
  bool _isCommentClick = false;

  void commentClick() {
    _isCommentClick = true;
    notifyListeners();
  }

  void notCommentClick() {
    _isCommentClick = false;
    notifyListeners();
  }

  bool get IsCommentClick {
    return _isCommentClick;
  }

  Future<DetailPostModel> loadDeatilPost(int id) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/detail/postdetail");

    Map data = {"content_id": id};
    print("id:$id");
    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DetailPostModel jsonResponse =
        detailPostModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<DetailTagModel> loadtagPost(String slug, int itmNum) async {
    final url = Uri.parse("https://dhakaprokash24.com/api/v1/tag/tagcontents");

    Map data = {"tag_slug": slug, "take": itmNum};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DetailTagModel jsonResponse =
        detailTagModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<DetailsAuthorModel> loadAuthorPost(String slug, int itmNum) async {
    final url =
        Uri.parse("https://dhakaprokash24.com/api/v1/author/getauthorpost");

    Map data = {"author_slug": slug, "take": itmNum};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DetailsAuthorModel jsonResponse =
        detailsMoreAuthorModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<DetailsMorePostModel> loadMoreCatPost(int catId, int contentId) async {
    final url = Uri.parse(
        "https://dhakaprokash24.com/api/v1/detail/firstrightcatcontent");

    Map data = {"cat_id": catId, "content_id": contentId};

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    DetailsMorePostModel jsonResponse =
        detailsMorePostModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }
}
