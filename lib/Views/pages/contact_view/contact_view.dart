import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    String mailSchema = "mailto";
    String websiteSchema = "https";
    Future<void> launchLink(String schema, String link) async {
      final Uri launchUri = Uri(scheme: schema, path: link);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Newsroom",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text("+8809613331010"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Marketing",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text("+8809613332020"),
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Website",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      launchLink(websiteSchema, 'https://dhakaprokash24.com');
                    },
                    child: Text(
                      'dhakaprokash24.com',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 24, 110, 180)),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: FollowSocialWidget(fontSize: 25, iconRadius: 18),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("93, Kazi Nazrul Islam Avenue")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
