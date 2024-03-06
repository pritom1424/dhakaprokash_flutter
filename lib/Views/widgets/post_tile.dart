import 'package:dummy_app/Models/post_model.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final PostModel postModel;
  const PostTile(this.postModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text("${postModel.title}+(${postModel.id})"),
        subtitle: Text(postModel.body),
        tileColor: Colors.amber,
      ),
    );
  }
}
