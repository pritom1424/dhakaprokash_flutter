import 'package:flutter/material.dart';

class FollowPostBar extends StatelessWidget {
  final double iconRadius;
  const FollowPostBar({super.key, required this.iconRadius});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Column(children: [
          Text("3",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            "Shares",
            style: TextStyle(fontSize: 12),
          )
        ]),
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
