import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_listtile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentCategoryHomeWidget extends StatelessWidget {
  final List<PhotoModel> photoModels;
  final List<PostModel> postModels;

  const RecentCategoryHomeWidget(
      {super.key, required this.photoModels, required this.postModels});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
//recent category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//part1 //recent categoryname + More button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              // height: scSize.height * 0.1,
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 151, 144, 144)))),
              child: Row(
                children: [
                  Text(
                    "Recent",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HomePage()));
                    },
                    icon: Icon(Icons.arrow_right),
                    label: Text("More"),
                  ),
                ],
              ),
            ),
          ),
//part2 //recent categorylists
          Container(
            height: scSize.height * 0.33,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  if (index < 5) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: RecentCategoryHomeListTile(
                        imagePath: photoModels[index].url,
                        newsTitle: photoModels[index]
                            .description, //postModels[index].title
                        newsDescription: postModels[index].body,
                        newsDate: DateFormat.yMEd().format(
                          DateTime.now(),
                        ),
                        newsCategory: "Saradesh",
                      ),
                    );
                  } else {
                    return Text("No list");
                  }
                }),
          )
        ],
      ),
    );
  }
}
