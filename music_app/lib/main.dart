import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/components/music_player.dart';

import 'components/sub_header.dart';
import 'components/header.dart';
import 'components/music_cover.dart';
import 'models/music.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List<Music> musics = [
    Music(
        singer: 'Pia Mia ft. Chris Brown, Tyga',
        cover: 'Pia Mia.jpeg',
        song: 'Pia Mia - Do It Again ft. Chris Brown, Tyga'),
    Music(
        singer: 'Chris Brown ft. Lil Wayne, Tyga',
        cover: 'Chris Brown.jpeg',
        song: 'Chris Brown - Loyal ft. Lil Wayne, Tyga'),
    Music(
        singer: 'Lil Dick ft Chris Brown',
        cover: 'Chris Brown.jpeg',
        song: 'Freaky Friday'),
  ];
  var currentMusic = 0;

  void _goToNextMusic(int music) {
    setState(() {
      currentMusic++;
    });
  }

  void _goToPreviousMusic(int music) {
    setState(() {
      currentMusic--;
    });
  }

  void _resetMusic() {
    setState(() {
      currentMusic = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[800],
              Colors.blue[200],
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Let's add some text title
                Header(label: "Music Beats"),
                SubHeader(label: "Listen to your favorite Music"),
                SizedBox(
                  height: 24.0,
                ),
                MusicCover(
                  cover: "assets/${musics[currentMusic].cover}",
                  singer: musics[currentMusic].singer,
                ),
                SizedBox(
                  height: 30.0,
                ),
                MusicPlayer(
                  currentMusic: currentMusic,
                  listOfMusic: musics,
                  goToNextMusic: _goToNextMusic,
                  goTopPreviousMusic: _goToPreviousMusic,
                  resetListOfMusic: _resetMusic,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
