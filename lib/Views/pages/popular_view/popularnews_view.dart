import 'package:flutter/material.dart';

class PopularNewsView extends StatelessWidget {
  const PopularNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Popular News",
        style: Theme.of(context).textTheme.bodyLarge,
      )),
    );
  }
}
