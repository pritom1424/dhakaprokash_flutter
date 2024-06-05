import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({Key? key});

  @override
  Widget build(BuildContext context) {
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

    return Container(
      color: Color.fromARGB(255, 235, 233, 227),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // width: scSize.width * 0.3, // Adjust as needed
            width: GenericVars.scSize.width, // Adjust as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/images/dhakaprokash_logo.png",
                    width: GenericVars.scSize.width * 0.6, // Adjust as needed
                    height: GenericVars.scSize.height * 0.06,
                  ),
                ),
                RichText(
                  //  textScaler: TextScaler.linear(1.3),
                  //   maxLines: 3,
                  text: TextSpan(
                      text: "ভারপ্রাপ্ত সম্পাদক: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: GenericVars.currenFontFamily,
                      ),
                      children: [
                        TextSpan(
                            text: "রবিউল ইসলাম\n",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: GenericVars.currenFontFamily,
                            )),
                        TextSpan(
                            text: "প্রকাশক: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: GenericVars.currenFontFamily,
                            )),
                        TextSpan(
                            text: "শাহাদৎ জামান সাইফ",
                            style: TextStyle(
                                fontFamily: GenericVars.currenFontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "৯৩, কাজী নজরুল ইসলাম এভিনিউ, (ষষ্ঠ তলা)\nকারওয়ান বাজার, ঢাকা-১২১৫।")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "নিউজরুম",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text("+৮৮০৯৬১৩৩৩১০১০"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "মার্কেটিং",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text("+৮৮০৯৬১৩৩৩২০২০"),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      launchLink(mailSchema, 'newsroom@dhakaprokash24.com');
                    },
                    child: Text(
                      'newsroom@dhakaprokash24.com',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 24, 110, 180)),
                    )),
                GestureDetector(
                    onTap: () {
                      launchLink(mailSchema, "marketking@dhakaprokash24.com");
                    },
                    child: Text(
                      'marketking@dhakaprokash24.com',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 24, 110, 180)),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: FollowSocialWidget(fontSize: 25, iconRadius: 18),
                ),
                /* const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("93, Kazi Nazrul Islam Avenue")), */
                Container(
                  color: Colors.white70, //Color.fromARGB(255, 17, 61, 117),
                  height: GenericVars.scSize.height * 0.05,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "© ২০২৪ সর্বস্বত্ব সংরক্ষিত | ঢাকাপ্রকাশ",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
