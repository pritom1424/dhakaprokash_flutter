import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({Key? key});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 235, 233, 227),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // width: scSize.width * 0.3, // Adjust as needed
            width: scSize.width, // Adjust as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/dhakaprokash_logo.png",
                        width: scSize.width * 0.5, // Adjust as needed
                        height: scSize.height * 0.07,
                      ),
                      Text("93, Kazi Nazrul Islam Avenue"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Newsroom",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text("+8801224323232"),
                          Text("test@test.com"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Marketing",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text("+8801224323232"),
                          Text("test@test.com"),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: FollowSocialWidget(fontSize: 25, iconRadius: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



/* import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

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
        if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $launchUri';
        }
      }
    }

    return Container(
      height: GenericVars.scSize.height * 0.30,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Color.fromARGB(255, 235, 233, 227),
      child: FittedBox(
        child: Column(
          //physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/dhakaprokash_logo.png",
                  width: GenericVars.scSize.width * 0.5,
                  height: GenericVars.scSize.height * 0.05,
                ),
                Text("93,Kazi Nazrul Islam Avenue")
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Column(
                children: [
                  Text(
                    "Newsroom",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text("+8801224323232"),
                  TextButton(
                      onPressed: () {
                        launchLink(mailSchema, 'newsroom@dhakaprokash24.com');
                      },
                      child: Text("newsroom@dhakaprokash24.com")),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Column(
                children: [
                  Text("Marketing",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text("+8801224323232"),
                  TextButton(
                      onPressed: () {
                        launchLink(mailSchema, "marketking@dhakaprokash24.com");
                      },
                      child: Text("marketking@dhakaprokash24.com")),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: FollowSocialWidget(fontSize: 18, iconRadius: 14)),
          ],
        ),
      ),
    );
  }
}
 */