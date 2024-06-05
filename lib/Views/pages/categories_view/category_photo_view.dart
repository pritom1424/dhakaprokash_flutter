import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPhotoView extends ConsumerWidget {
  final int albumId;
  const CategoryPhotoView({super.key, required this.albumId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppbarDefault(),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future:
                ref.watch(categoryViewController).loadDetailPhotoItem(albumId),
            builder: (ctx, snap) => (snap.connectionState ==
                    ConnectionState.waiting)
                ? SizedBox(
                    height: GenericVars.scSize.height * 0.6,
                    width: double.infinity,
                    child: const LoaderWidget())
                : (snap.hasData)
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snap.data!.albumName ?? "এলবাম",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border.symmetric(
                                      vertical: BorderSide(
                                          width: 0.3, color: Colors.grey))),
                              child: Text(
                                  "প্রকাশঃ ${DateFormatter().defaultFormatWithTime(snap.data!.createdAt ?? DateTime.now())}"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                children: List.generate(
                                    snap.data!.photoGalleries.length,
                                    (index) => Container(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                  'https://admin.dhakaprokash24.com/media/photoAlbum/${snap.data!.photoGalleries[index].photo}'),
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 5),
                                                decoration: const BoxDecoration(
                                                    color: Colors.black12),
                                                child: Text(
                                                  snap
                                                          .data!
                                                          .photoGalleries[index]
                                                          .photoCapture ??
                                                      "ছবি: ঢাকাপ্রকাশ",
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
                            const HomePageFooter()
                          ],
                        ),
                      )
                    : const SizedBox.shrink()),
      ),
    );
  }
}
