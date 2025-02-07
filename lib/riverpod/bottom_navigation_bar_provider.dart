import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationBarProvider =
    StateNotifierProvider<BottomNavigationBarProvider, int>(
        (ref) => BottomNavigationBarProvider());

class BottomNavigationBarProvider extends StateNotifier<int> {
  BottomNavigationBarProvider() : super(0);

  void updateIndex(int index) {
    state = index;
  }
}
