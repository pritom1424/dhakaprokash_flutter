import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Controllers/category_controller.dart';
import 'package:dummy_app/Controllers/detailpage_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/login_controller.dart';

import 'package:dummy_app/Controllers/registration_controller.dart';
import 'package:dummy_app/Controllers/searchpage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/app_colors.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/scroll_controller.dart';

import 'package:dummy_app/Views/pages/splash_screen.dart';
import 'package:dummy_app/database/database_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
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
      ChangeNotifierProvider(create: (_) => BookmarkController()),
      ChangeNotifierProvider(create: (_) => SearchPageController()),
      ChangeNotifierProvider(create: (_) => CategoryViewController()),
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

      theme: ThemeData(
        primarySwatch:
            Colors.blue, // You can change this to match your app's color scheme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).copyWith(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 35,
                ),
                titleMedium: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  //  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 20,
                ),
                titleSmall: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 15,
                ),
                bodyLarge: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 25,
                ),
                bodyMedium: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.normal,
                  //  fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16,
                ),
                headlineMedium: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.normal,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 20,
                ),
                headlineLarge: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 25,
                ),
                labelMedium: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 12,
                ),
                labelSmall: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.normal,
                  // fontFamily: GenericVars.currenFontFamily,
                  color: Colors.black87,
                  fontSize: 12,
                ),
              )),

      //
    );
  }
}
