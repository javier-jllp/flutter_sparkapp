import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/sembast_service.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, MyThemes>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<MyThemes> {
  final ThemeModel _themeModel;
  ThemeNotifier() : _themeModel = ThemeModel(), super(MyThemes.light) {
    _initTheme();
  }

  Future<void> _initTheme() async {
    final theme = await _themeModel.currentTheme;
    state = theme;
  }

  Future<void> toggleTheme() async {
    await _themeModel.toggleTheme();
    final newTheme = await _themeModel.currentTheme;
    state = newTheme;
  }
}

class ThemeModel {
  static final ThemeModel _instance = ThemeModel._internal();
  factory ThemeModel() => _instance;
  ThemeModel._internal();
  final SembastService _sembast =
      SembastService(); // Asegúrate de que SembastService esté bien implementado

  Future<MyThemes> get currentTheme async {
    final themeData = await _sembast.getJson(_sembast.themeStore, 1);
    final themeString =
        themeData?['theme'] ?? 'light'; // 'light' como valor por defecto
    return themeString == 'dark' ? MyThemes.dark : MyThemes.light;
  }

  Future<void> toggleTheme() async {
    final _currentTheme = await currentTheme;
    final newTheme = _currentTheme == MyThemes.dark ? 'light' : 'dark';
    await _sembast.putJson(_sembast.themeStore, 1, {'id': 1, 'theme': newTheme});
  }
}

enum MyThemes { light, dark }
