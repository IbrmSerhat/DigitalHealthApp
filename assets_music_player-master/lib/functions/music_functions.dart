import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_music_player/second%20screen/play_musicScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double screenHeight = 0;

double screenWidth = 0;

ValueNotifier<bool> miniPlayerVisibility = ValueNotifier(false);
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

Widget functionMiniPlayer(BuildContext context) {
  return audioPlayer.builderRealtimePlayingInfos(
      builder: (context, realtimePlayingInfos) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const PlayMusicScreen();
        }));
      },
      onDoubleTap: () {
        miniPlayerVisibility.value = false;
        audioPlayer.pause();
      },
      child: Visibility(
        visible: miniPlayerVisibility.value,
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 118, 65, 153),
              borderRadius: BorderRadius.circular(14)),
          // color: Colors.yellow,
          height: 75,
          // color: Colors.amber,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  realtimePlayingInfos.current!.audio.audio.metas.image!.path,
                  fit: BoxFit.cover,
                  height: 78,
                  width: 78,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        realtimePlayingInfos.current!.audio.audio.metas.title
                            .toString(),
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        realtimePlayingInfos.current!.audio.audio.metas.artist
                            .toString(),
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      audioPlayer.pause();
                      audioPlayer.previous();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if(audioPlayer.isPlaying == true){audioPlayer.pause();audioPlayer.play();}
                        else if (audioPlayer.isPlaying == false) {audioPlayer.pause(); }
                        audioPlayer.playOrPause();
                      },
                      icon: realtimePlayingInfos.isPlaying
                          ? const Icon(
                              Icons.pause,
                              size: 40,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow_rounded,
                              size: 40,
                              color: Colors.white,
                            )),
                  IconButton(
                    onPressed: () {
                      audioPlayer.pause();
                      audioPlayer.next();
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  });
}

//---------------Playlist screen start--------------------------------

Widget playlistNameScreen({required String playlistTitle, context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(65)),
        color: const Color.fromARGB(255, 118, 65, 153),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ListTile(
            title: Text(
              playlistTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (){

            }
          ),
        )),
  );
}
