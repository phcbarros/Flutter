import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/components/sub_header.dart';
import 'package:music_app/components/volume_slider.dart';

import 'components/header.dart';

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
  bool playing = false; // at the begining wer are not playing any song
  IconData playBtn = Icons.play_arrow; // the main state of the play button icon
  double volume = 1.0;
  List<Music> musics = [
    Music(
      singer: 'Pia Mia - Do It Again ft. Chris Brown, Tyga',
      cover: 'Pia Mia.jpeg'),
    Music(
      singer: 'Chris Brown - Loyal ft. Lil Wayne, Tyga',
      cover: 'Chris Brown.jpeg'),
    Music(
      singer: 'Freaky Friday',
      cover: 'Chris Brown.jpeg')
  ];
  var currentMusic = 0;

  // Now let's start by creating our music player
  // firts let's declare some object
  AudioPlayer _player;
  AudioCache cache;

  Duration position = Duration(seconds: 0);
  Duration musicLength = Duration(seconds: 1); // fix bug slider

  // We will create a custom slider

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  _twoDigits(int n) => n.toString().padLeft(2, "0");

  // let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  // Now let's initialize our player
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    // Now let's handle the audio player time

    // this function will allow you to get the music duration
    _player.onDurationChanged.listen((Duration duration) {
      setState(() {
        musicLength = duration;
      });
    });

    // this function will allow us to move the cursor of the slider while we are playing the song
    _player.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    }, onError: (e) {
      print('Erro ao obter posição');
    });

    _player.onPlayerCompletion.listen((_) {
      if (_canGoToNextMusic()) {
        _goToNextMusic();
      } else {
        setState(() {
          currentMusic = 0;
          position = Duration(seconds: 0);
          playing = false;
          playBtn = Icons.play_arrow;
        });
      }
    });
  }

  bool _canGoToNextMusic() {
    return currentMusic < musics.length - 1 ? true : false;
  }

  void _goToNextMusic() {
    setState(() {
      currentMusic++;
      cache.play("${musics[currentMusic].singer}.mp3");
    });
  }

  bool _canGoToPreviousMusic() {
    return currentMusic == 0 ? false : true;
  }

  void _goToPreviousMusic() {
    setState(() {
      currentMusic--;
      cache.play("${musics[currentMusic].singer}.mp3");
    });
  }

  void onChangeVolume(value) {
    _player.setVolume(value);
    setState(() {
      volume = value;
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
            ]
          )
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
                // let's ad the music cover
                Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/${musics[currentMusic].cover}"))),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      musics[currentMusic].singer,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // let's start by adding the controller
                        Container(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${position.inMinutes.remainder(60)}:${_twoDigits(position.inSeconds.remainder(60))}",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              slider(),
                              Text(
                                "${musicLength.inMinutes}:${_twoDigits(musicLength.inSeconds.remainder(60))}",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45,
                              color: _canGoToPreviousMusic() ? Colors.blue : Colors.grey,
                              onPressed: () {
                                if(_canGoToPreviousMusic())
                                  _goToPreviousMusic();
                              },
                              icon: Icon(
                                Icons.skip_previous,
                              ),
                            ),
                            IconButton(
                              iconSize: 45,
                              color: Colors.blue,
                              onPressed: () {
                                if (!playing) {
                                  // now let's play the song
                                  cache.play("${musics[currentMusic].singer}.mp3");
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },
                              icon: Icon(
                                playBtn,
                              ),
                            ),
                            IconButton(
                              iconSize: 45,
                              color: _canGoToNextMusic() ? Colors.blue : Colors.grey,
                              onPressed: () {
                                if (_canGoToNextMusic())  
                                  _goToNextMusic();
                              },
                              icon: Icon(
                                Icons.skip_next,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "Volume",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            VolumeSlider(volume: volume, onVolumeChanged: onChangeVolume),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Music {
  final String singer;
  final String cover;

  Music({this.singer, this.cover});
}
