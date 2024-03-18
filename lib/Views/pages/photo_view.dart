import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Views/widgets/photo_tile.dart';
import 'package:dummy_app/Views/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    PhotoController photoController = Provider.of<PhotoController>(context);

    print(photoController.visibleItems.length);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dummy App"),
        ),
        body: FutureBuilder(
            future: photoController.loadItems(),
            builder: (ctx, snapShot) => (snapShot.connectionState ==
                    ConnectionState.waiting)
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: photoController.visibleItems.length + 1,
                    itemBuilder: (ctx, index) {
                      if (index < photoController.visibleItems.length) {
                        return PhotoTile(photoController.visibleItems[index]);
                      } else {
                        if (photoController.showButton) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                photoController.loadMoreItems();
                              },
                              child: const Text("ReadMore"));
                        } else {
                          return const Text(
                              "You have reached to the end of the page");
                        }
                      }
                    })));
  }
}
