import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class MainPostTile extends StatelessWidget {
  final String url, title, boldDescription, description;
  const MainPostTile(
      {super.key,
      required this.url,
      required this.title,
      required this.boldDescription,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: GenericVars.scSize.height * 0.8,
          child: ListView(children: [
            //title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.start,
              ),
            ),
            //News Post Image
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              height: GenericVars.scSize.height * 0.3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    url,
                    fit: BoxFit.fitWidth,
                  )),
            ),
            //Main News Post
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "$boldDescription\n\n",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: description,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black))
            ]))
          ]),
        ));
  }
}
