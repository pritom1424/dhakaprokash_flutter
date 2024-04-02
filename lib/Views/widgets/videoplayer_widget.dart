import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
  bool isLoading = false;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(
            autoPlay: false, mute: false, isLive: false, loop: false));

    _controller.initialVideoId;
    _controller.load(widget.videoId);
    _controller.addListener(() {});

    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void ChangeVideo() {
    _controller.pause();

    _controller.load(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    ChangeVideo();

    return YoutubePlayer(
      onReady: () {
        (widget.isPause) ? _controller.pause() : _controller.play();
      },
      showVideoProgressIndicator: true,
      controller: _controller,
      width: GenericVars.scSize.width * 1,
      aspectRatio: 16 / 9,
    );

    /* Container(
      color: Colors.black,
      height: GenericVars.scSize.width * (16 / 9),
      child: Stack(children: [
        Container(
          color: Colors.black,
          child: Align(
            alignment: Alignment.center,
            child: YoutubePlayer(
              onReady: () {
                Provider.of<VideoProvider>(context, listen: false)
                    .changeLoadVideoState();
                (widget.isPause) ? _controller.pause() : _controller.play();
              },
              showVideoProgressIndicator: true,
              controller: _controller,
              width: GenericVars.scSize.width * 1,
              aspectRatio: 16 / 9,
            ),
          ),
        ),
        Consumer<VideoProvider>(
          builder: (ctx, snapShot, ch) => (snapShot.isLoading)
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: GenericVars.scSize.height * 0.3,
                    color: const Color.fromARGB(255, 218, 209, 209),
                    child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        child:
                            Image.asset("assets/images/dhakaprokash_logo.png")),
                  ),
                )
              : SizedBox.shrink(),
        )
      ]),
    ); */
  }
}
