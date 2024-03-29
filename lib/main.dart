import 'package:dummy_app/Controllers/detailpage_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/login_controller.dart';

import 'package:dummy_app/Controllers/registration_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/scroll_controller.dart';

import 'package:dummy_app/Views/pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart' as ds;

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 169, 162, 255),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ds.initializeDateFormatting('bn');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(
        create: (_) => RegistrationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => HomepageController(),
      ),
      ChangeNotifierProvider(
        create: (_) => ScrollControl(),
      ),
      ChangeNotifierProvider(create: (_) => VideoProvider()),
      ChangeNotifierProvider(create: (_) => DetailPageController()),
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
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 35,
                ),
                titleMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 20,
                ),
                titleSmall: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 15,
                ),
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 25,
                ),
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 18,
                ),
                headlineMedium: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 20,
                ),
                headlineLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 25,
                ),
                labelMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 12,
                ),
                labelSmall: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: GenericVars.currenFontFamily,
                  color: Colors.black87,
                  fontSize: 12,
                ),
              )),

      //
    );
  }
}
