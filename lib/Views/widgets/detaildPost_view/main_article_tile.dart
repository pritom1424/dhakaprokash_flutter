import 'package:flutter/material.dart';

class MainArticleTile extends StatelessWidget {
  final List<Widget> articleItems;
  const MainArticleTile({super.key, required this.articleItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: articleItems,
    );
  }
}
