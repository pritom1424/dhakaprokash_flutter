import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Views/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);

    print(postController.visibleItems.length);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dummy App"),
        ),
        body: FutureBuilder(
            future: postController.loadItems(),
            builder: (ctx, snapShot) =>
                (snapShot.connectionState == ConnectionState.waiting)
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: postController.visibleItems.length + 1,
                        itemBuilder: (ctx, index) {
                          if (index < postController.visibleItems.length) {
                            return PostTile(postController.visibleItems[index]);
                          } else {
                            if (postController.showButton == true) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    postController.loadMoreItems();
                                  },
                                  child: const Text("ReadMore "));
                            } else {
                              return Text(ApiConstant.visibleItemCount.toString());
                            }
                          }
                        })));
  }
}
