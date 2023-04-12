import 'package:flutter/material.dart';
import 'package:assets_music_player/functions/music_List.dart';
import 'package:assets_music_player/functions/music_functions.dart';

import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SecondPage extends StatelessWidget {
  final String title;
  SecondPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EkSayfa(title: title);
  }
}

class EkSayfa extends StatefulWidget {
  final String title;
  EkSayfa({Key? key, required this.title}) : super(key: key);

  @override
  State<EkSayfa> createState() => EkSayfaIcerik();
}

class EkSayfaIcerik extends State<EkSayfa> {
  late String title = widget.title;

  @override
  void initState(){
    super.initState();
    musicListFunction();
  }

  List<Audio> music_search = List.from(musicList);

  void musicListFunction() {
    setState(() {
      music_search = musicList
          .where((element) =>
          element.metas.artist!.toLowerCase().contains(title.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    title = widget.title;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(title),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      backgroundColor: Color.fromARGB(255, 36, 19, 60),
      body:ListView.builder(
          itemCount: music_search.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    music_search[index].metas.image!.path,
                    fit: BoxFit.cover,
                    height: 172.03,
                    width: 60,
                  )),
              title: Text(
                music_search[index].metas.title.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white, fontSize: 18),
              ),
              subtitle: Text(
                music_search[index].metas.artist.toString(),
                style: const TextStyle(
                    color: Color.fromARGB(135, 255, 255, 255),
                    fontSize: 14),
              ),
              trailing: Text(
                '$index',
                style: const TextStyle(
                    color: Color.fromARGB(135, 255, 255, 255),
                    fontSize: 14),
              ),
              onTap: () {
                audioPlayer.playOrPause();
                audioPlayer.open(Playlist(audios: music_search),
                    autoStart: false,
                    loopMode: LoopMode.playlist,
                    showNotification: true,
                    notificationSettings: NotificationSettings(stopEnabled: false));
                audioPlayer.playlistPlayAtIndex(index);
                miniPlayerVisibility.value = true;
              },
            );
      }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: functionMiniPlayer(context),
      ),
    );
  }
}