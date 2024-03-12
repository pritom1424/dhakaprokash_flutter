import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Views/pages/home_view/home_view.dart';
import 'package:dummy_app/Views/pages/splash_screen.dart';
import 'package:dummy_app/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 169, 162, 255),
);
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PostController()),
      ChangeNotifierProvider(create: (_) => PhotoController())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplasScreen(),
      theme: ThemeData().copyWith(
          textTheme: ThemeData().textTheme.copyWith(
              bodyLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "QuickSand",
                color: kColorScheme.onSecondaryContainer,
                fontSize: 25,
              ),
              bodyMedium: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: "QuickSand",
                color: kColorScheme.onSecondaryContainer,
                fontSize: 15,
              ),
              headlineMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "QuickSand",
                color: kColorScheme.onSecondaryContainer,
                fontSize: 15,
              ),
              headlineLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "QuickSand",
                color: kColorScheme.onSecondaryContainer,
                fontSize: 25,
              ),
              labelMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "QuickSand",
                color: kColorScheme.onSecondaryContainer,
                fontSize: 12,
              ))),
      //
    );
  }
}
