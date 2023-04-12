import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_music_player/functions/music_List.dart';
import 'package:assets_music_player/second%20screen/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:like_button/like_button.dart';

import '../functions/music_functions.dart';

RealtimePlayingInfos? realtimePlayingInfosPlayMusicScreen;

class PlayMusicScreen extends StatefulWidget {
  const PlayMusicScreen({super.key});

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
//  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,

        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Text('ŞifaName'),
        ),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        actions: [
          SizedBox(
            //width: 5,
            width: screenWidth * 0.013,
          ),

          SizedBox(
            //width: 20,
            width: screenWidth * 0.045,
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 36, 19, 60),
        // backgroundColor: const Color.fromARGB(255, 241, 5, 5),
        elevation: 0,
      ),
      body: audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos) {
          if (realtimePlayingInfos != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  musicImage(realtimePlayingInfos),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  musicTitle(realtimePlayingInfos),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  musicArtist(realtimePlayingInfos),
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  // SizedBox(height: screenHeight*0.5,),
                  slider(realtimePlayingInfos),
                  timeStamps(realtimePlayingInfos),
                  musicControl(realtimePlayingInfos)
                ],
              ),
            );
          } else {
            return Column(
              children: const [Text('No Music')],
            );
          }
        },
      ),
    );
  }

  Widget musicImage(RealtimePlayingInfos realtimePlayingInfos) {
    return SizedBox(
        height: screenHeight * 0.355,
        width: screenWidth * 0.699,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              realtimePlayingInfos.current!.audio.audio.metas.image!.path,
              fit: BoxFit.cover,
            )));
  }

  Widget musicTitle(RealtimePlayingInfos realtimePlayingInfos) {
    return Text(
      realtimePlayingInfos.current!.audio.audio.metas.title.toString(),
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget musicArtist(RealtimePlayingInfos realtimePlayingInfos) {
    return Text(
      realtimePlayingInfos.current!.audio.audio.metas.artist.toString(),
      style: const TextStyle(
          color: Color.fromARGB(135, 255, 255, 255), fontSize: 18),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget likedIconMusic(RealtimePlayingInfos realtimePlayingInfos) {
    return const LikeButton(
      size: 35,
      // isLiked: true,
      animationDuration: Duration(),
    );
  }

  // Widget musicSlide(RealtimePlayingInfos realtimePlayingInfos){
  //   return Stack(
  //     children: [
  //       Positioned(child: Container(
  //         height: screenHeight*0.3,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(colors: [
  //             Colors.purple,
  //             Color.fromARGB(255, 176, 39, 39),
  //             Color.fromARGB(255, 0, 143, 5),
  //             Color.fromARGB(255, 212, 254, 0),
  //           ],stops: [0.0,0.55,0.55,1.0],end: Alignment.bottomCenter,begin: Alignment.topCenter )
  //         ),
  //       )),SliderTheme(data: SliderThemeData(trackShape: customTrackshape()), child: child)
  //     ],
  //   );
  // }

  Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
    return Stack(
      children: [
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: Colors.white,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Color.fromARGB(65, 222, 222, 222),
          ),
          child: Slider.adaptive(
            value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
            max: realtimePlayingInfos.duration.inSeconds.toDouble() + 3,
            min: -3,
            onChanged: ((value) {
              if (value <= 0) {
                audioPlayer.seek(const Duration(seconds: 0));
              } else if (value >= realtimePlayingInfos.duration.inSeconds) {
                audioPlayer.seek(realtimePlayingInfos.duration);
              } else {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget timeStamps(RealtimePlayingInfos realtimePlayingInfos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            transformString(realtimePlayingInfos.currentPosition.inSeconds),
            style: const TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: screenWidth * 0.7,
          ),
          Text(
            transformString(realtimePlayingInfos.duration.inSeconds),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String transformString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString';
  }

  Widget musicControl(RealtimePlayingInfos realtimePlayingInfos) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  audioPlayer.pause();
                  audioPlayer.previous();
                },
                child: const Icon(
                  Icons.skip_previous_rounded,
                  size: 45,
                  color: Colors.white,
                ),
              ),
              // GestureDetector(
              //   child: const Icon(
              //     Icons.play_circle_fill,
              //     size: 45,
              //     color: Colors.white,
              //   ),
              // ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if(audioPlayer.isPlaying == true){audioPlayer.pause();audioPlayer.play();}
                  else if (audioPlayer.isPlaying == false) {audioPlayer.pause(); }
                  audioPlayer.playOrPause();
                },
                child: realtimePlayingInfos.isPlaying
                    ? const Icon(
                        Icons.pause_circle_filled,
                        size: 45,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.play_circle_fill,
                        size: 45,
                        color: Colors.white,
                      ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  audioPlayer.pause();
                  audioPlayer.next();
                },
                child: const Icon(
                  Icons.skip_next_rounded,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// class customTrackshape extends RoundedRectSliderTrackShape{
//   Rect getPreferredReact({
//     required RenderBox parentbox,
//   })
// }