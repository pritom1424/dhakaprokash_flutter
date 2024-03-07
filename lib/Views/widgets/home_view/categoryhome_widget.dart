import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/widgets/home_view/categoryhome_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CategoryHomeWidget extends StatelessWidget {
  final String categoryName;
  final List<PhotoModel> photoModels;
  final List<PostModel> postModels;
  const CategoryHomeWidget(
      {super.key,
      required this.photoModels,
      required this.postModels,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
//category home widget column startted
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//part 1//categoryname + More Button section

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: GenericVars.scSize.height * 0.07,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 151, 144, 144)))),
                child: Row(
                  children: [
                    Text(
                      categoryName,
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

//part 2//HeadImagePreview
            Container(
              width: double.infinity,
              height: GenericVars.scSize.height * 0.3,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    photoModels[0].url,
                    fit: BoxFit.fitWidth,
                  )),
            ),

//part 3//Category News Lists
            Container(
              height: GenericVars.scSize.height * 0.33,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    if (index < 5) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: CategoryHomeListTile(
                            categoryName: categoryName,
                            imagePath: photoModels[index].url,
                            newsTitle: photoModels[index].description,
                            newsDescription: postModels[index].body,
                            /*postModels[index].title, */
                            newsDate: DateFormat.yMEd().format(DateTime.now())),
                      );
                    } else {
                      return Text("No list");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
