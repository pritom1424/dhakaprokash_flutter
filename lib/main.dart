import 'package:dummy_app/Utils/app_colors.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/pages/splash_screen.dart';
import 'package:dummy_app/database/database_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/date_symbol_data_local.dart' as ds;

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 169, 162, 255),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDb();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ds.initializeDateFormatting('bn');
  runApp(
    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplasScreen(),

      theme: ThemeData(
        primarySwatch:
            Colors.blue, // You can change this to match your app's color scheme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).copyWith(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 35, //40, //35
                ),
                titleMedium: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GenericVars.currenFontFamily,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 25 //25 //22,
                    ),
                titleSmall: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GenericVars.currenFontFamily,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 17 //17 //15,
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
                    color: Colors.black,
                    fontSize: 18 //18, //20, //16 //15,
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
