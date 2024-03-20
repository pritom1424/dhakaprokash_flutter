import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoId;
  final bool isPause;

  const VideoPlayerWidget(
      {super.key, required this.videoId, required this.isPause});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // _controller.dispose();
    // _controller.pause();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(
            autoPlay: false, mute: false, isLive: false, loop: false));

    /*   _controller.dispose();
    _controller.pause(); */

    _controller.initialVideoId;
    _controller.load(widget.videoId);
    _controller.addListener(() {
      print("test video");
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("youtube video id: ${widget.videoId}");
    return YoutubePlayer(
      onReady: () {
        (widget.isPause) ? _controller.pause() : _controller.play();
      },
      showVideoProgressIndicator: true,
      controller: _controller,
      width: GenericVars.scSize.width * 1,
      aspectRatio: 16 / 9,
    );
  }
}
