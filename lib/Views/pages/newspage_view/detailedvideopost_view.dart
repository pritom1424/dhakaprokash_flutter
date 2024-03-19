import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/videoplayer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    GenericVars.currentPageVideoLink = widget.videoUrl;
    print("init call");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double itemHeight = 0.09;
    int listItemLength = 3;
    String currentURl = GenericVars.currentPageVideoLink;
    //print("youtube url: ${GenericVars.currentPageVideoLink}");
/*     List<Map<String, String>> currentList =
        GenericVars.getVideoData.sublist(listItemLength + 1); */

    /* currentList.insert(
        currentList.indexWhere(
            (element) => element['url'] == GenericVars.currentPageVideoLink),
        currentList[currentList.length]); */
    return Scaffold(
      appBar: AppbarDefault(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.3,
                          color: Color.fromARGB(255, 136, 135, 135)))),
              width: double.infinity,
              height: GenericVars.scSize.height * 0.7,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: VideoPlayerWidget(
                          videoId: YoutubePlayer.convertUrlToId(currentURl)!)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: GenericVars.scSize.height *
                        itemHeight *
                        (listItemLength),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          listItemLength,
                          (index) => Container(
                                height: GenericVars.scSize.height * itemHeight,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 0.4, color: Colors.grey))),
                                child: ListTile(
                                  onTap: () {
                                    GenericVars.currentPageVideoLink =
                                        GenericVars.getVideoData[index + 1]
                                            ['url']!;
                                    setState(() {});
                                  },
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2),
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/video_play_icon.png"),
                                    radius: 20,
                                  ),
                                  title: Expanded(
                                    child: Container(
                                      child: Text(
                                        GenericVars.getVideoData[index + 1]
                                            ['title']!,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  titleTextStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                    ),
                  )
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
            )
          ],
        ),
      ),
    );
  }
}
