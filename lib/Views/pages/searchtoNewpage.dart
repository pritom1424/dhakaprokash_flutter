import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchToNewPage extends StatelessWidget {
  String searchString;
  SearchToNewPage(this.searchString, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "search page",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Center(
        child: Text(
          searchString,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
