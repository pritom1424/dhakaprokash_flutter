import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhotoTile extends StatelessWidget {
  final PhotoModel photoModel;
  const PhotoTile(this.photoModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              FadeInImage.assetNetwork(
                  placeholder: "assets/images/image_placeholder.jpg",
                  image: photoModel.url),
              Text(
                "${photoModel.title} ${photoModel.id}",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ));
  }
}
