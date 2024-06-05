import 'package:avatar_glow/avatar_glow.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/latest_view/latestnews_view.dart';
import 'package:flutter/material.dart';
import 'package:dummy_app/Views/pages/categories_view/categorywise_video_view.dart';

class CategoryButtonList extends StatefulWidget {
  final List<String> foundCategories;
  const CategoryButtonList({super.key, required this.foundCategories});

  @override
  State<CategoryButtonList> createState() => _CategoryButtonListState();
}

class _CategoryButtonListState extends State<CategoryButtonList> {
  bool _showScrollToTop = false;
  late ScrollController _scrollController;
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0.0);

  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(_updateScrollOffset);
    _showScrollToTop = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _updateScrollOffset() {
    _scrollOffset.value = _scrollController.offset;
    if (_scrollOffset.value >= _scrollController.position.maxScrollExtent) {
      _showScrollToTop = true;
    } else {
      _showScrollToTop = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: GenericVars.scSize.height * 0.7,
          color: Colors.white,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 5),
            shrinkWrap: true,
            children: List.generate(
                widget.foundCategories.length,
                (index) => Container(
                      // height: GenericVars.scSize.height * 0.07,
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.3, color: Colors.grey))),
                      child: ListTile(
                        leading: Icon(
                            color: Colors.blueGrey,
                            GenericVars.newspaperCategories.values
                                .toList()[index]),
                        title: Text(
                          widget.foundCategories[index],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: GenericVars.currenFontFamily),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            if (widget.foundCategories[index] ==
                                "ভিজ্যুয়াল মিডিয়া") {
                              return CategryWiseVideo(
                                isEnableAppbar: true,
                              ); /* const CategoryVideoView(
                                isEnableAppbar: true,
                              ); */
                            } else if (widget.foundCategories[index] ==
                                "সর্বশেষ") {
                              return const LatestNewsView(
                                isEnableAppbar: true,
                              );
                            } else {
                              return CategoryView(
                                  catSlug: GenericVars.newspaperCategoriesLink[
                                      widget.foundCategories[index]],
                                  categoryName: widget.foundCategories[index]);
                            }
                          }));
                        },
                      ),
                    )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ValueListenableBuilder(
            valueListenable: _scrollOffset,
            builder: (ctx, offset, _) => AvatarGlow(
              animate: GenericVars.isAppdrawerGlow,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    _scrollController.animateTo(
                      (_showScrollToTop)
                          ? 0.0
                          : _scrollController.offset +
                              _scrollController.position.maxScrollExtent / 3.2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon((_showScrollToTop)
                      ? Icons.keyboard_double_arrow_up
                      : Icons.keyboard_double_arrow_down),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );

    /* ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => SingleCategoryTile());
  } */
  }
}
