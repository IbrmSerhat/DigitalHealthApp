import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_music_player/functions/music_List.dart';
import 'package:assets_music_player/functions/music_functions.dart';
import 'package:flutter/services.dart' show rootBundle;

class Muzik {
  String _dosyaYolu;
  String _muzikAdi;
  String _hastaliklar;
  List<String> _hastalikList;
  String _foto;

  String get dosyaYolu => _dosyaYolu;
  set dosyaYolu(String value) => _dosyaYolu = value;

  String get muzikAdi => _muzikAdi;

  String get hastaliklar => _hastaliklar;
  set hastaliklar(String value) => _hastaliklar = value;

  List<String> get hastalikList => _hastalikList;
  set hastalikList(List<String> value) => _hastalikList = value;

  String get foto => _foto;
  set foto(String value) => _foto = value;

  Muzik(this._dosyaYolu,this._muzikAdi,this._hastaliklar,this._hastalikList,this._foto);

  factory Muzik.fromString(String s) {
    final parts = s.split(':');
    final dosyaYolu = parts[0];
    final muzikAdi = dosyaYolu.substring(7, dosyaYolu.length - 4);
    final hastaliklar = parts[1];
    final hastalikList = parts[1].split(',');
    final foto = parts[2];
    return Muzik(dosyaYolu,muzikAdi, hastaliklar,hastalikList, foto);
  }
}

Future<List<Muzik>> readMuzikList() async {
  final String? content = await rootBundle.loadString('assets/mbilgi.txt');
  final List<Muzik> muzikList = content?.split('\n').map((s) => Muzik.fromString(s)).toList() ?? [];
  return muzikList;
}

List<Audio> musicList = [];
List<Muzik> muzikler =  [];
List<String> flitreliMusicList = [];

void setUp() async {
  musicList = await musicListFiller();
  muzikler = await readMuzikList() ?? [];
  flitreliMusicList = await flitreleMusicList();
}

Future<List<Audio>> musicListFiller() async {
  List<Muzik> muzikler = await readMuzikList() ?? [];
  List<Audio> musicList = [];
  for(int i = 0 ; i<muzikler.length;i++){
    Audio temp = new Audio( muzikler[i].dosyaYolu,
        metas: Metas( title: muzikler[i].muzikAdi,
            artist: muzikler[i].hastaliklar,
            image: MetasImage.asset(muzikler[i].foto)
        ));

    musicList.add(temp);
  }
  return musicList;
}

Future<List<String>> flitreleMusicList() async {
  List<String> flitreler = <String>[];
  List<Muzik> muzikler = await readMuzikList() ?? [];
  for(int i = 0 ; i<muzikler.length;i++){ //[a,b,c]
    for(int j = 0; j<muzikler[i].hastalikList.length; j++){ //[a],b,c
      bool flag = true;
      for(int k = 0 ; k<flitreler.length;k++){
        if(muzikler[i].hastalikList[j] == flitreler[k]){
          flag = false;
        }
      }
      if(flag){
        flitreler.add(muzikler[i].hastalikList[j]);
      }
    }
  }
  return flitreler;
}

void setUpPlayList() async {
  await audioPlayer.open(Playlist(audios: musicList),
      autoStart: false,
      loopMode: LoopMode.playlist,
      showNotification: true,
      notificationSettings: NotificationSettings(stopEnabled: false));

}

/*
List<Audio> musicList = [
  Audio('assets/dippam-dappam-kaathuvaakula-rendu-kaadhal-128-kbps-sound.mp3',
      metas: Metas(
          title: 'Dippam Dippim',
          artist: 'Aniruth',
          image: MetasImage.asset('assets/dippam dippam.png'))),
  Audio(
      'assets/the-monster-song-extended-version-kgf-chapter-2-tamil-128-kbps-sound.mp3',
      metas: Metas(
          title: 'KGF',
          artist: 'Shabaash mithu',
          image: MetasImage.asset('assets/kgf.png'))),
  Audio('assets/Karineela_Kayalukondu_(KuttyWap.com).mp3',
      metas: Metas(
          title: 'Honey bee',
          artist: 'Shabaash mithu',
          image: MetasImage.asset('assets/honey-bee.png'))),
  Audio('assets/Eminem-Alfred-Outro-(HiphopKit.com).mp3',
      metas: Metas(
          title: 'Eminum alfred',
          artist: 'Eminum',
          image: MetasImage.asset('assets/Eminem-Alfred-Outro-artwork.webp'))),
  Audio('assets/Eminem-No-Regrets-Ft-Don-Toliver-(HiphopKit.com).mp3',
      metas: Metas(
          title: 'Eminum no regret',
          artist: 'Eminum',
          image: MetasImage.asset('assets/Eminem-Alfred-Outro-artwork.webp'))),
];*/
