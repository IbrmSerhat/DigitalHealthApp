import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_music_player/music%20screens/my_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../functions/music_List.dart';
import '../functions/music_functions.dart';
import '../music screens/liked_screen.dart';
//import '../music screens/my_music.dart';
import '../music screens/play_listScreen.dart';
import '../second screen/SearchScreen.dart';

class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({super.key});

  @override
  State<TabHomeScreen> createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
  //final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 8,

              backgroundColor: Color.fromARGB(255, 36, 19, 60),
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Colors.transparent,
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                unselectedLabelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                tabs: [
                  Tab(
                    text: 'Müzikler',
                    icon: Icon(Icons.music_note),
                  ),
                  Tab(
                    text: 'Ara',
                    icon: Icon(Icons.search),
                  ),
                  Tab(
                    text: 'Hastalıklar',
                    icon: Icon(Icons.list_alt),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              MyMusicScreen(),
              SearchScreen(),
              PLaylistScreen(),
            ]),
            bottomSheet: Padding(
              padding: EdgeInsets.all(8),
              child: functionMiniPlayer(context),
            ),
          ),
        ));
  }
}
