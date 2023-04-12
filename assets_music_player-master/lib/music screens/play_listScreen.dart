import 'package:assets_music_player/functions/music_List.dart';
import 'package:assets_music_player/other screen/flitrelenmisList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../functions/music_functions.dart';

class PLaylistScreen extends StatefulWidget {
  const PLaylistScreen({super.key});

  @override
  State<PLaylistScreen> createState() => _PLaylistScreenState();
}

class _PLaylistScreenState extends State<PLaylistScreen> {
  @override
  Widget build(BuildContext context) {
    bool isFloatVisible = false;
    return SafeArea(
        child: Scaffold(
            body: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {

                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage(title: flitreliMusicList[index]),
                    ),
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.list_outlined,color: Colors.white),
                  title: Text(flitreliMusicList[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        ),
                    ),

                ),
              ),
              itemCount: flitreliMusicList.length,
            ),
        ),
    );
  }
}


/*
SizedBox(
                    height: 1,
                  ),
                  playlistNameScreen(
                    context: context,
                    playlistTitle: 'Playlist One',
                  ),
                  playlistNameScreen(
                    context: context,
                    playlistTitle: 'Playlist Two',
                  ),
                  playlistNameScreen(
                    context: context,
                    playlistTitle: 'Playlist Three',
                  ),



ListView.builder(itemBuilder: (context, index) =>
ListTile(
leading: const Icon (Icons.music_note),
title: Text("aaa"),
subtitle: Text("bbb1"),
), itemCount: 5,),

*/

/*

ListView.builder(
itemBuilder: (context, index) => InkWell(
onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondPage(title: flitrelenmisList[index]),
                          ),
                        );
},
child: ListTile(
leading: const Icon(Icons.file_copy_outlined),
title: Text("sdfgdsfgdfgsg"),
),
),
itemCount: muzikler.length,
),
*/


