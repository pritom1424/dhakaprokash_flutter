import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/mainpost_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailedPostView extends StatelessWidget {
  final String url, title, description, categoryName;
  const DetailedPostView(
      {super.key,
      required this.url,
      required this.title,
      required this.description,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 30),
          child: Image.asset(
            "assets/images/dhakaprokash_logo.png",
            width: GenericVars.scSize.width * 0.5,
            height: GenericVars.scSize.height * 0.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainPostTile(
                url: url,
                title: title,
                description: description,
                boldDescription: description,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: GenericVars.scSize.height * 0.5,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$categoryName",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 7 / 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 5,
                          children: List.generate(
                              7,
                              (index) => Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          border: Border.all(width: 1)),
                                      child: TextButton(
                                          onPressed: () {}, child: Text("tag")),
                                    ),
                                  ))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
