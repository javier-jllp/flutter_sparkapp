import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/theme.dart';
import '../my_widgets/app_bar.dart';
import 'profiles/private/my_profile_screen.dart';
import './images/list_image_screen.dart';
import './videos/list_video_screen.dart';

class RootScreen extends StatefulWidget {
  RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final currentTheme = ref.watch(themeProvider);
        final themeNotifier = ref.read(themeProvider.notifier);

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: myAppBar(context, themeNotifier, currentTheme),
            body: const TabBarView(
              children: [
                ListImageScreen(),
                ListVideoScreen(),
                MyProfileScreen(),
              ],
            ),
            bottomNavigationBar: TabBar(
              unselectedLabelColor: currentTheme == MyThemes.light
                  ? Colors.grey[900]
                  : Colors.grey[400],
              labelColor: currentTheme == MyThemes.light
                  ? Colors.blue 
                  : Colors.green[200],
              indicatorColor: currentTheme == MyThemes.light
                  ? Colors.green 
                  : Colors.blue[200],
              tabs: const <Widget> [
                Tab(
                  icon: Icon(Icons.image),
                  text: 'Imágenes',),
                Tab(
                  icon: Icon(Icons.videocam_sharp),
                  text: 'Videos',),
                Tab(
                  icon: Icon(Icons.account_circle),
                  text: 'Javier',),
              ],
            ),
          )
        );
      },
    );
  }
}

