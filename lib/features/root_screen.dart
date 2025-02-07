import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/theme.dart';
import '../my_widgets/app_bar.dart';
import 'profiles/private/my_profile_screen.dart';
import './images/list_image_screen.dart';
import './videos/list_video_screen.dart';
import './synchronize_db.dart';
import '../riverpod/bottom_navigation_bar_provider.dart';

class RootScreen extends StatefulWidget {
  RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final SynchronizeImmutableTables _syncDb = SynchronizeImmutableTables();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final currentTheme = ref.watch(themeProvider);
        final themeNotifier = ref.read(themeProvider.notifier);
        final currentIndexNotifier =
            ref.read(bottomNavigationBarProvider.notifier);
        final currentIndex = ref.watch(bottomNavigationBarProvider);
        return FutureBuilder(
          future: _syncDb.synchronizeTablesDb(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Text('Error al sincronizar los datos: ${snapshot.error}'),
              );
            } else {
              // snapshot.connectionState == ConnectionState.done
              return _pages(themeNotifier, currentTheme, currentIndexNotifier,
                  currentIndex);
            }
          },
        );
      },
    );
  }
}

Widget _pages(ThemeNotifier themeNotifier, MyThemes currentTheme,
    BottomNavigationBarProvider currentIndexNotifier, int currentIndex) {
  final List<Widget> pages = [
    const ListImageScreen(),
    const ListVideoScreen(),
    const MyProfileScreen()
  ];
  return Scaffold(
    appBar: myAppBar(themeNotifier, currentTheme),
    body: PageView(
      controller: PageController(initialPage: currentIndex),
      children: pages,
      onPageChanged: (newIndex) {
        currentIndexNotifier.updateIndex(newIndex);
      },
    ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor:
          currentTheme == MyThemes.dark ? Colors.grey[850] : Colors.blue[50],
      unselectedItemColor: 
          currentTheme == MyThemes.dark ? Colors.green[100] : Colors.grey[800],
      selectedItemColor: 
          currentTheme == MyThemes.dark ? Colors.green : Colors.blue,
      currentIndex: currentIndex,
      onTap: (value) => currentIndexNotifier.updateIndex(value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'Imágenes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videocam_sharp),
          label: 'Videos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
    ),
  );
}
