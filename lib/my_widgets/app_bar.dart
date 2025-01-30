import 'package:flutter/material.dart';
import 'package:sparkapp/riverpod/theme.dart';

PreferredSizeWidget myAppBar(
    BuildContext context, ThemeNotifier themeNotifier, MyThemes currentTheme) {
  return AppBar(
    title: const Text('SparkApp'),
    backgroundColor: currentTheme == MyThemes.dark
        ? const Color.fromARGB(255, 31, 31, 31)
        : const Color.fromARGB(255, 136, 201, 255),
    actions: <Widget>[
      IconButton(
        onPressed: (){},
        icon: const Icon(Icons.search),
      ),
      IconButton(
        icon: Icon(
            currentTheme == MyThemes.dark ? Icons.light_mode : Icons.dark_mode),
        onPressed: () {
          themeNotifier.toggleTheme();
        },
      ),
    ],
  );
}
