import 'dart:convert';

import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(),
      body: FutureBuilder(
          future: HomepageController()
              .loadAllItems(ApiConstant.homePageSpecialContentLink),
          builder: (ctx, snapshot) => (snapshot.connectionState ==
                  ConnectionState.waiting)
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Center(
                    child: (snapshot.data!.isNotEmpty && snapshot.data != null)
                        ? SingleChildScrollView(
                            child: Column(
                            children: List.generate(
                                snapshot.data!.length,
                                (index) => ListTile(
                                        title: Container(
                                      child: Image.network(
                                          "https://admin.dhakaprokash24.com/media/content/images${snapshot.data![index].imgBgPath.toString()}"),
                                    ))),
                          ))
                        : Container(),
                  ),
                )),
    );
  }
}
