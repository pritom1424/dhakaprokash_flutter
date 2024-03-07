import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryHomeListTile extends StatelessWidget {
  final String imagePath, newsTitle, newsDate;
  const CategoryHomeListTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDate});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => HomePage()));
      },
      child: Container(
        height: scSize.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          border:
              const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
//Category News Row Started
        child: Row(
          children: [
//Category News Image
            Expanded(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                  )),
            ),
//Category News Description s+ Date
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      StringLimiter().limitString(newsTitle, 50),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(newsDate)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
