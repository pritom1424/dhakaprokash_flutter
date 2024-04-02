import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowSocialWidget extends StatelessWidget {
  final double fontSize;
  final double iconRadius;
  const FollowSocialWidget(
      {super.key, required this.fontSize, required this.iconRadius});

  @override
  Widget build(BuildContext context) {
    String facebookLink = "https://www.facebook.com/dhakaprokash24";
    String instaLink = "https://www.instagram.com/dhakaprokash24/";
    String twitterLink = "https://twitter.com/dhakaprokash24";
    String youtubeLink = "https://www.youtube.com/DhakaProkash";

    String mailSchema = "mailto";
    String websiteSchema = "https";
    Future<void> launchLink(String schema, String link) async {
      final Uri launchUri = Uri(scheme: schema, path: link);
      //final Uri launchWebUri = Uri.parse(link);
      // final Uri currentURi = launchUri;
      if (schema.contains(websiteSchema)) {
        if (!await launchUrl(Uri.parse(link))) throw 'Could not launch $link';
      } else {
        if (!await launchUrl(launchUri)) throw 'Could not launch $link';
        /* if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $launchUri';
        } */
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Follow", style: TextStyle(fontSize: fontSize))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                launchLink(websiteSchema, facebookLink);
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
                launchLink(websiteSchema, youtubeLink);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/youtube-icon.png")),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchLink(websiteSchema, instaLink);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/instagram_icon.png")),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchLink(websiteSchema, twitterLink);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                    radius: iconRadius,
                    child: Image.asset("assets/images/twitter-icon.png")),
              ),
            )
          ],
        ),
      ],
    );
  }
}
