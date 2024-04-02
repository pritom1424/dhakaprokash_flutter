import 'package:dummy_app/Views/widgets/cat_widgets/favlist_tile.dart';
import 'package:dummy_app/database/database_helper.dart';
import 'package:flutter/material.dart';

class BookmarkController with ChangeNotifier {
  List<FavListTile>? _favoritesList = [];
  DatabaseHelper _db = DatabaseHelper();

  Future<void> addToList(FavListTile favListTile) async {
    await _db.savePost(favListTile);
    if (_favoritesList != null) {
      _favoritesList!.insert(0, favListTile);
    }
    notifyListeners();
  }

  Future<void> removeFromList(int id) async {
    await _db.deletePost(id);
    if (_favoritesList != null) {
      _favoritesList!.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  Future<void> getFromList() async {
    if (_favoritesList != null) {
      _favoritesList!.clear();
    }
    _favoritesList = await _db.getPosts();
    notifyListeners();
  }

  List<FavListTile> get FavList {
    return [..._favoritesList!];
  }
}
