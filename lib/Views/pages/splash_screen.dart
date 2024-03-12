import 'dart:async';

import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/pages/home_view/home_view.dart';
import 'package:dummy_app/Views/pages/post_view.dart';
import 'package:flutter/material.dart';

class SplasScreen extends StatefulWidget {
  SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => HomeView()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: scSize.width * 0.8,
              height: scSize.height * 0.2,
              child: Image.asset(
                "assets/images/dhakaprokash_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
