import 'package:flutter/material.dart';

class LatestNewsView extends StatelessWidget {
  const LatestNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Latest News",
        style: Theme.of(context).textTheme.bodyLarge,
      )),
    );
  }
}
