import 'package:flutter/material.dart';

class FollowSocialWidget extends StatelessWidget {
  final double fontSize;
  final double iconRadius;
  const FollowSocialWidget(
      {super.key, required this.fontSize, required this.iconRadius});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text("Follow", style: TextStyle(fontSize: fontSize))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: iconRadius,
                child: Image.asset("assets/images/facebook-icon.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                  radius: iconRadius,
                  child: Image.asset("assets/images/youtube-icon.png")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                  radius: iconRadius,
                  child: Image.asset("assets/images/instagram_icon.png")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                  radius: iconRadius,
                  child: Image.asset("assets/images/twitter-icon.png")),
            )
          ],
        ),
      ],
    );
  }
}
