import 'package:dummy_app/Controllers/category_controller.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CategoryPhotoView extends StatelessWidget {
  final int albumId;
  const CategoryPhotoView({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    CategoryViewController categoryViewController =
        Provider.of<CategoryViewController>(context);

    return Scaffold(
      appBar: AppbarDefault(),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: categoryViewController.loadDetailPhotoItem(albumId),
            builder: (ctx, snap) => (snap.connectionState ==
                    ConnectionState.waiting)
                ? LoaderWidget()
                : (snap.hasData)
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snap.data!.albumName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      vertical: BorderSide(
                                          width: 0.3, color: Colors.grey))),
                              child: Text(
                                  "প্রকাশঃ ${DateFormatter().defaultFormatWithTime(snap.data!.createdAt)}"),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Column(
                                children: List.generate(
                                    snap.data!.photoGalleries.length,
                                    (index) => Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                  'https://admin.dhakaprokash24.com/media/photoAlbum/${snap.data!.photoGalleries[index].photo}'),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.black12),
                                                child: Text(
                                                  snap
                                                      .data!
                                                      .photoGalleries[index]
                                                      .photoCapture,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                              ),
                            ),
                            HomePageFooter()
                          ],
                        ),
                      )
                    : SizedBox.shrink()),
      ),
    );
  }
}
