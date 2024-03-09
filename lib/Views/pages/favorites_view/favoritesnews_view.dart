import 'package:flutter/material.dart';

class FavoritesNewsView extends StatelessWidget {
  const FavoritesNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Favorites",
        style: Theme.of(context).textTheme.bodyLarge,
      )),
    );
  }
}
