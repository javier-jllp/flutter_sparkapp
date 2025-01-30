import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, MyThemes>(
  (ref) => ThemeNotifier()
);


class ThemeNotifier extends StateNotifier<MyThemes> {
  ThemeNotifier(): super(MyThemes.dark);

  void toggleTheme() {
    state = state == MyThemes.dark ? MyThemes.light : MyThemes.dark;
  }
}


enum MyThemes {light, dark}