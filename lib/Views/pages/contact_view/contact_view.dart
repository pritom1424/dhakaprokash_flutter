import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    launchTest(String url) async {
      if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
    }

    return Scaffold(
      //appBar: AppbarDefault(0.6),
      body: Container(
        height: GenericVars.scSize.height,
        width: double.infinity,
        //color: Color.fromARGB(255, 235, 233, 227),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/dhakaprokash_logo.png",
              width: GenericVars.scSize.width * 0.7,
              height: GenericVars.scSize.height * 0.1,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    "Contact us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("93,Kazi Nazrul Islam Avenue")
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    "Website",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                      onPressed: () {
                        //  _launchLink(websiteSchema, 'dhakaprokash24.com');
                        launchLink(websiteSchema, 'https://dhakaprokash24.com');
                      },
                      child: Text("www.dhakaprokash24.com")),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    "Newsroom",
                    style: Theme.of(context).textTheme.bodyLarge,
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
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text("Marketing",
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text("+8801224323232"),
                  TextButton(
                      onPressed: () {
                        launchLink(mailSchema, "marketking@dhakaprokash24.com");
                      },
                      child: Text("marketking@dhakaprokash24.com")),
                ],
              ),
            ),
            /*  Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: FollowSocialWidget(fontSize: 25, iconRadius: 20)), */
          ],
        ),
      ),
    );
  }
}
