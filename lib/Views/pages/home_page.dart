import 'package:dummy_app/Views/pages/photo_view.dart';
import 'package:dummy_app/Views/pages/post_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy App"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => PostView()));
              },
              child: Text("Post View")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => PhotoView()));
              },
              child: Text("Photo View")),
        ],
      ),
    );
  }
}
