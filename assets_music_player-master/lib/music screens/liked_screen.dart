import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_music_player/functions/music_List.dart';
import 'package:assets_music_player/functions/music_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';

class LikedScreen extends StatelessWidget {
  // final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  //const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            controller: ScrollController(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    musicList[index].metas.image!.path,
                    fit: BoxFit.cover,
                    height: 172.03,
                    width: 60,
                  ),
                ),
                title: Text(
                  musicList[index].metas.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(135, 255, 255, 255), fontSize: 14),
                ),
                onTap: () {
                  audioPlayer.playlistPlayAtIndex(index);
                  miniPlayerVisibility.value = true;
                },
              );
            },
            itemCount: musicList.length,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
