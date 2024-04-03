import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

enum Social { facebook, twitter, whatsapp, linkedin, messenger }

class FollowPostBar extends StatelessWidget {
  final double iconRadius;
  final String dummyLink = "https://www.dhakaprokash24.com/national/news/60447";
  const FollowPostBar({super.key, required this.iconRadius});

  Future<void> launchLink(String link, Social sc, String postText) async {
    String formatLink = linkFormatter(sc, link, postText);

    if (!await launchUrl(Uri.parse(formatLink)))
      throw 'Could not launch $formatLink';
  }

  String linkFormatter(Social social, String url, String text) {
    switch (social) {
      case Social.facebook:
        return 'https://www.facebook.com/sharer/sharer.php?u=$url&t=$text';
      //"$formatUrl";
      case Social.twitter:
        return 'https://twitter.com/intent/tweet?url=$url&text=$text';
      case Social.linkedin:
        return 'https://linkedin.com/shareArticle?mini=true&url=$url';

      case Social.whatsapp:
        return 'https://api.whatsapp.com/send?text=$text$url';
      case Social.messenger:
        return '';

      default:
        return "you need to login";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /* 'https//www.facebook.com/sharer/sharer.php?u=$urlshare&t=$text'
'https//twitter.com/intent/tweet?url=$urlshare&text=$text'
'https//api.whatsapp.com/send?text=$text$urlshare'
'https//linkedin.com/shareArticle?mini=true&url=$urlshare' */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                launchLink(dummyLink, Social.facebook, "here");
                //test();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  radius: iconRadius,
                  child: Image.asset("assets/images/facebook-icon.png"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // launchLink(dummyLink, Social.whatsapp, "here is a new post");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/messenger-icon.png")),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchLink(dummyLink, Social.whatsapp, "here is a new post");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/whatsapp-icon.png")),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchLink(dummyLink, Social.twitter, "here is a new post");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/twitter-icon.png")),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchLink(dummyLink, Social.linkedin, "here is a new post");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/linkedin-icon.png")),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchLink(dummyLink, Social.linkedin, "here is a new post");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/copy-icon.png")),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
