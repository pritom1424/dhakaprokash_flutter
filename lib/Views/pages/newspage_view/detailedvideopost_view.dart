import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/followpost_bar.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:dummy_app/Views/widgets/videoplayer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailedVideoPostView extends StatefulWidget {
//  final String categoryName, videoUrl, videoTitle;

  final int id;
  const DetailedVideoPostView({
    super.key,
    required this.id,
    // required this.videoUrl,
    // required this.videoTitle,
  });

  @override
  State<DetailedVideoPostView> createState() => _DetailedVideoPostViewState();
}

class _DetailedVideoPostViewState extends State<DetailedVideoPostView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: false);

    double itemHeight = 0.09;
    int listItemLength = 3;
    return Scaffold(
      appBar: const AppbarDefault(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: videoProvider.getSingleVideo(widget.id),
          builder: (ctx, snap) => (snap.hasData)
              ? Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.3,
                              color: Color.fromARGB(255, 136, 135, 135)))),
                  width: double.infinity,
                  //height: GenericVars.scSize.height * 0.7,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VideoPlayerWidget(
                          isPause: false,
                          videoId: snap.data!.currentVideo.code ?? ""),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          snap.data!.currentVideo.title ?? "",
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
                      FollowPostBar(
                          iconRadius: 12,
                          isFullLink: true,
                          postText: "ভিডিওটি দেখতে ক্লিক করুন",
                          link:
                              "https://www.youtube.com/watch?v=${snap.data!.currentVideo.code}"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: GenericVars.scSize.height *
                            itemHeight *
                            (snap.data!.getVideos.length),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              snap.data!.getVideos.length,
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
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    DetailedVideoPostView(
                                                      id: snap
                                                              .data!
                                                              .getVideos[index]
                                                              .id ??
                                                          -1,
                                                    )));
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
                                          snap.data!.getVideos[index].title ??
                                              "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      titleTextStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                              GenericVars.currenFontFamily),
                                    ),
                                  )),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: GenericVars.scSize.height * 0.6,
                  child: Center(
                    child: LoaderWidget(),
                  ),
                ),
        ),
      ),
    );
  }
}
