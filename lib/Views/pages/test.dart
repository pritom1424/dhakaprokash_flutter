import 'dart:convert';

import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(),
      body: FutureBuilder(
          future: HomepageController().loadAllItems(),
          builder: (ctx, snapshot) =>
              (snapshot.connectionState == ConnectionState.waiting)
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: Center(
                        child: Text(snapshot.data!.body),
                      ),
                    )),
    );
  }
}
