import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

enum Social { facebook, twitter, whatsapp, linkedin, messenger }

class FollowPostBar extends StatelessWidget {
  final double iconRadius;
  final bool? isFullLink;
  final String? postText;
  final String link;
  const FollowPostBar(
      {super.key,
      required this.iconRadius,
      required this.link,
      this.postText,
      this.isFullLink});

  Future<void> launchLink(String link, Social sc, String postText) async {
    String formatLink = linkFormatter(sc, link, postText);

    if (!await launchUrl(Uri.parse(formatLink)))
      throw 'Could not launch $formatLink';
  }

  void _copyToClipBoard(String text, BuildContext ctx) async {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      content: Text(
        'Link copied to clipboard',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.blue,
    ));
    await Clipboard.setData(ClipboardData(text: text));
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
        return 'fb-messenger://share/?link=$url&app_id=184941580989360';

      default:
        return "you need to login";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String postLink = (isFullLink == null || isFullLink == false)
        ? "https://www.dhakaprokash24.com$link"
        : link;

    final String textString =
        (postText == null) ? "খবরটি পড়তে ক্লিক করুন\n" : "${postText!}\n";
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
                launchLink(postLink, Social.facebook, textString);
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
                launchLink(postLink, Social.messenger, textString);
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
                launchLink(postLink, Social.whatsapp, textString);
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
                launchLink(postLink, Social.twitter, textString);
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
                launchLink(postLink, Social.linkedin, textString);
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
                _copyToClipBoard(postLink, context);
                //launchLink(dummyLink, Social.linkedin, "here is a new post");
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
