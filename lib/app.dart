import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sparkapp/riverpod/theme.dart';
import 'package:sparkapp/routes.dart';

class SparkApp extends ConsumerWidget {
  const SparkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _theme = ref.watch(themeProvider);

    return MaterialApp.router(
        title: 'SparkApp',
        debugShowCheckedModeBanner: false,
        theme: _theme == MyThemes.light
            ? ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: Colors.blue[50],
                textTheme:  GoogleFonts.robotoTextTheme(
                  const TextTheme(
                    bodyMedium: TextStyle(color: Colors.black),
                  ),
                )
              )
            : ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: Colors.grey[850],
                textTheme: GoogleFonts.robotoTextTheme(
                  const TextTheme(
                    bodyMedium: TextStyle(color: Colors.white),
                  ),
                )),
        routerConfig: myRouter
      );
  }
}
