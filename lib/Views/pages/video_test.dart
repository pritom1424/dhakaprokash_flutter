import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/videoplayer_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTest extends StatelessWidget {
  const VideoTest({super.key});

  @override
  Widget build(BuildContext context) {
    final vId = YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=HKvtByXSNG4");
    return Scaffold(
      // appBar: AppbarDefault(),
      body: Center(child: VideoPlayerWidget(videoId: vId!)),
    );
  }
}
