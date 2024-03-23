import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_data.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';

import 'package:dummy_app/Views/pages/newspage_view/detailedvideopost_view.dart';

import 'package:dummy_app/Views/widgets/videoplayer_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CategoryVideoWidget extends StatelessWidget {
  final String categoryName;
  /*  final List<PhotoModel> photoModels;
  final List<PostModel> postModels; */
  final List<DhakaProkash> dhakaprokashModels;

  final bool didMoreButtonShow;
  final bool didHeadSectionShow;
  final int listItemLength;
  final bool didFloat;
  final bool didPause;

  const CategoryVideoWidget({
    super.key,
    required this.dhakaprokashModels,
    required this.categoryName,
    required this.didMoreButtonShow,
    required this.didHeadSectionShow,
    required this.listItemLength,
    required this.didFloat,
    required this.didPause,
  });

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 0.09;
    final vId =
        YoutubePlayer.convertUrlToId(GenericVars.getVideoData[0]['url']!);
    return Container(
      //category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//part 1//categoryname + More Button section

          if (didMoreButtonShow)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        CategoryView(categoryName: categoryName)));
              },
              child: Container(
                  height: GenericVars.scSize.height * 0.07,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  /*  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              width: 0.3,
                              color: Color.fromARGB(255, 151, 144, 144)))), */
                  child: Row(
                    children: [
                      Text(
                        categoryName,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.red,
                      ),
                    ],
                  )),
            ),

//part 2//HeadImagePreview + title+description
          if (didHeadSectionShow)
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.3,
                          color: Color.fromARGB(255, 136, 135, 135)))),
              width: double.infinity,
              height: GenericVars.scSize.height * 0.35,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child:
                          VideoPlayerWidget(isPause: didPause, videoId: vId!)),
                  /*  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            dhakaprokashModels[0].contentHeading!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(StringLimiter().limitString(
                              dhakaprokashModels[0].contentDetails!, 97)),
                          Text(
                            DateFormat.yMEd()
                                .format(dhakaprokashModels[0].createdAt!),
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),
                  ) */
                ],
              ),
            ),

//part 3//Category News Lists
          Container(
            height:
                GenericVars.scSize.height * itemHeight * (listItemLength - 1),
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: List.generate(
                  listItemLength - 1,
                  (index) => Container(
                        height: GenericVars.scSize.height * itemHeight,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 0.4, color: Colors.grey))),
                        child: ListTile(
                          onTap: () {
                            Provider.of<VideoProvider>(context, listen: false)
                                .pauseVideoState();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => DetailedVideoPostView(
                                        categoryName: categoryName,
                                        videoUrl: GenericVars
                                            .getVideoData[index + 1]['url']!,
                                        videoTitle:
                                            GenericVars.getVideoData[index + 1]
                                                ['title']!)));
                          },
                          contentPadding: EdgeInsets.symmetric(vertical: 2),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/video_play_icon.png"),
                            radius: 20,
                          ),
                          title: Container(
                            child: Text(
                              GenericVars.getVideoData[index + 1]['title']!,
                              softWrap: true,
                            ),
                          ),
                          titleTextStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: GenericVars.currenFontFamily),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
