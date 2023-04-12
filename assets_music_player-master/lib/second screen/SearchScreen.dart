import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_music_player/functions/music_List.dart';
import 'package:assets_music_player/functions/music_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Audio> music_search = List.from(musicList);

  void musicListFunction(String value) {
    setState(() {
      music_search = musicList
          .where((element) =>
              element.metas.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => musicListFunction(value),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 118, 65, 153),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'Songs,artist or album',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(117, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  cursorColor: Colors.green,
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: music_search.isEmpty
                    ? const Center(
                        child: Text(
                        'Muzik Bulunamadı.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ))
                    : ListView.builder(
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
                        })),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: functionMiniPlayer(context),
      ),
    );
  }
}
