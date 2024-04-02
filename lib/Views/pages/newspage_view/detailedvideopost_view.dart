import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/videoplayer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailedVideoPostView extends StatefulWidget {
  final String categoryName, videoUrl, videoTitle;
  const DetailedVideoPostView({
    super.key,
    required this.categoryName,
    required this.videoUrl,
    required this.videoTitle,
  });

  @override
  State<DetailedVideoPostView> createState() => _DetailedVideoPostViewState();
}

class _DetailedVideoPostViewState extends State<DetailedVideoPostView> {
  late String currentUrl;
  List<Map<String, String>> currentContainer = [];

  List<Map<String, String>> currentElementList(String url, int itemNumber) {
    List<Map<String, String>> currentContainer = [];
    int first = (GenericVars.getVideoData
                    .indexWhere((element) => element['url'] == url) +
                1) <
            GenericVars.getVideoData.length
        ? GenericVars.getVideoData
                .indexWhere((element) => element['url'] == url) +
            1
        : 0;

    currentContainer.clear();

    currentContainer = List.from(GenericVars.getVideoData.sublist(first))
      ..addAll(GenericVars.getVideoData.sublist(0, first));

    currentContainer = currentContainer.sublist(0, itemNumber);
    print("Current Container $currentContainer");
    return currentContainer;
  }

  @override
  void initState() {
    currentUrl = widget.videoUrl;
    currentContainer = currentElementList(widget.videoUrl, 3);

    VideoProvider provider = Provider.of<VideoProvider>(context, listen: false);
    provider.setCurrentVideoLink(widget.videoUrl);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  Provider.of<VideoProvider>(context, listen: false)
        .CurrentVideoLink(videoUrl); */

    double itemHeight = 0.09;
    int listItemLength = 3;
    return Scaffold(
      appBar: AppbarDefault(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.3, color: Color.fromARGB(255, 136, 135, 135)))),
          width: double.infinity,
          height: GenericVars.scSize.height * 0.7,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  //video player
                  child: VideoPlayerWidget(
                      isPause: false,
                      videoId: YoutubePlayer.convertUrlToId(
                          Provider.of<VideoProvider>(context)
                              .CurrentVideoLink)!)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  Provider.of<VideoProvider>(context).currentTitle,
                  // widget.videoTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    DateFormatter().defaultFormat(DateTime.now()),
                    // DateFormat.yMEd().format(DateTime.now()),
                    style: TextStyle(color: Colors.grey),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                height:
                    GenericVars.scSize.height * itemHeight * (listItemLength),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      listItemLength,
                      (index) => Container(
                            height: GenericVars.scSize.height * itemHeight,
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 0.4, color: Colors.grey))),
                            //List Tile Started
                            child: ListTile(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => DetailedVideoPostView(
                                            categoryName: "Video",
                                            videoUrl: currentContainer[index]
                                                ['url']!,
                                            videoTitle: currentContainer[index]
                                                ['title']!)));

                                /* Provider.of<VideoProvider>(context,
                                        listen: false)
                                    .setCurrentVideoLink(
                                        currentContainer[index]['url']!);
                                currentContainer = currentElementList(
                                    currentContainer[index]['url']!, 3); */
                              },
                              contentPadding: EdgeInsets.symmetric(vertical: 2),
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/video_play_icon.png"),
                                radius: 20,
                              ),
                              title: Container(
                                child: Text(
                                  currentContainer[index]['title']!,
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
              ),
              /* Consumer<VideoProvider>(
                builder: (ctx, snapshot, ch) {
                  return Container(
                    height: GenericVars.scSize.height *
                        itemHeight *
                        (listItemLength),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          listItemLength,
                          (index) => Container(
                                height:
                                    GenericVars.scSize.height * itemHeight,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 0.4,
                                            color: Colors.grey))),
                                //List Tile Started
                                child: ListTile(
                                  onTap: () {
                                    Provider.of<VideoProvider>(context,
                                            listen: false)
                                        .setCurrentVideoLink(
                                            currentContainer[index]
                                                ['url']!);
                                    currentContainer =
                                        GenericVars.getVideoData;
                                    currentContainer.removeWhere(
                                        (element) =>
                                            element['url'] ==
                                            currentContainer[index]
                                                ['url']!);
                                  },
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2),
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/video_play_icon.png"),
                                    radius: 20,
                                  ),
                                  title: Container(
                                    child: Text(
                                      currentContainer[index]['title']!,
                                      softWrap: true,
                                    ),
                                  ),
                                  titleTextStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                    ),
                  );
                },
              ) */
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
      ),
    );
  }
}
