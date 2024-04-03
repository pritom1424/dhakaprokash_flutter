import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_photo_model.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPhotoGridWidget extends StatefulWidget {
  final List<DhakaProkashPhotoModel> dhakaprokashModels;
  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  final Color? barIconColor, barTextColor;
  final int totalPhotoItems;
  const CategoryPhotoGridWidget(
      {super.key,
      required this.itemCount,
      required this.dhakaprokashModels,
      required this.didAxisHorizontal,
      required this.crossAxisCount,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.itemHeight,
      this.barIconColor,
      this.barTextColor,
      required this.totalPhotoItems});

  @override
  State<CategoryPhotoGridWidget> createState() =>
      _CategoryPhotoGridWidgetState();
}

class _CategoryPhotoGridWidgetState extends State<CategoryPhotoGridWidget> {
  late ScrollController scController;
  @override
  void initState() {
    scController = ScrollController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    scController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cellHeight = 0.3;
    double mainAxisSpacing = 10;
    return Column(
      children: [
        Container(
          height: GenericVars.scSize.height * 0.07,
          width: double.infinity,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
                      width: 0.3, color: Color.fromARGB(255, 151, 144, 144)))),
          child: Row(
            children: [
              Icon(
                Icons.square,
                color: (widget.barIconColor) ?? AppColors.categoryNameColor,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ফটো গ্যালারি",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    color: (widget.barTextColor) ?? Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_right,
                color: (widget.barIconColor) ?? AppColors.categoryNameColor,
              )
            ],
          ),
        ),
        Container(
          height: (widget.didAxisHorizontal)
              ? GenericVars.scSize.height * (widget.itemHeight ?? cellHeight)
              : GenericVars.scSize.height *
                  (widget.itemHeight ?? cellHeight) *
                  (widget.itemCount / widget.crossAxisCount).ceil(),
          child: Scrollbar(
            controller: scController,
            thickness: 5,
            child: GridView.builder(
                controller: scController,
                itemCount: widget.itemCount,
                physics: (widget.isScroll)
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  mainAxisSpacing: mainAxisSpacing,
                ),
                scrollDirection: (widget.didAxisHorizontal)
                    ? Axis.horizontal
                    : Axis.vertical,
                itemBuilder: (ctx, index) => Card(
                      elevation: widget.elevation,
                      child: Container(
                        height: GenericVars.scSize.height * cellHeight,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "https://admin.dhakaprokash24.com/media/photoAlbum/${widget.dhakaprokashModels[index].photo}",
                                          fit: BoxFit.fill,
                                          filterQuality: FilterQuality.low,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              (loadingProgress == null)
                                                  ? child
                                                  : Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40),
                                                      child: Image.asset(
                                                        "assets/images/dhakaprokash_logo.png",
                                                      ),
                                                    ),
                                        )),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: Text(
                                          widget.dhakaprokashModels[index]
                                              .albumName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white60,
                                    child: Icon(Icons.photo_rounded)))
                          ],
                        ),
                      ),
                    )),
          ),
        ),
        Consumer<HomepageController>(
          builder: (ctx, snap, _) => Visibility(
            visible: snap.IsMoreButtonVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                  onPressed: () {
                    Provider.of<HomepageController>(context, listen: false)
                        .addMorePhotos(widget.totalPhotoItems);
                  },
                  child: Text("আরও")),
            ),
          ),
        )
      ],
    );
  }
}
