import 'dart:convert';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/favlist_tile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'posts.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, category_name TEXT, description TEXT, caption TEXT, date TEXT,tags TEXT, imagePath TEXT)');
    });
  }

/*final String imagePath,
      newsTitle,
      newsDescription,
      categoryName,
      imageCaption;
  final DateTime dateTime;
  final double itemHeight;
  final List<String> tags; */
  Future<int> savePost(FavListTile categoryListTile) async {
    var client = await db;
    Map<String, dynamic> data = {
      'id': categoryListTile.id,
      'title': categoryListTile.newsTitle,
      'category_name': categoryListTile.categoryName,
      'description': categoryListTile.newsDescription,
      'caption': categoryListTile.imageCaption,
      'date': categoryListTile.dateTime.toIso8601String(),
      'tags': json.encode(categoryListTile.tags),
      'imagePath': categoryListTile.imagePath
    };

    GenericVars.favoritesList?.insert(0, categoryListTile);
    return client.insert('posts', data);
  }

  Future<int> deletePost(int id) async {
    var client = await db;
    GenericVars.favoritesList?.removeWhere((element) => element.id == id);
    return await client.delete('posts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavListTile>> getPosts() async {
    var client = await db;
    var res = await client.query('posts');
    if (res.isEmpty) return [];
    GenericVars.favoritesList?.clear();
    GenericVars.favoritesList = res
        .map((postMap) => FavListTile(
            id: postMap['id'] as int,
            imagePath: postMap['imagePath'].toString(),
            newsTitle: postMap['title'].toString(),
            newsDescription: postMap['description'].toString(),
            categoryName: postMap['category_name'].toString(),
            itemHeight: 0.17,
            dateTime: DateTime.parse(postMap['date'].toString()),
            imageCaption: postMap['caption'].toString(),
            tags: postMap['tags'].toString().split(',')))
        .toList();
    return GenericVars.favoritesList ?? [];
  }
}
